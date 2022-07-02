# frozen_string_literal: true
class StatusPurchaseController < ApplicationController
  before_action :redirect_if_cant_buy!, only: [:new_transaction]
  before_action :set_status_purchase_by_id, only: [:confirm]

  def new_transaction
    status_purchase = create_pending_status_purchase
    redirect_to epoch_uri(@status, status_purchase)
  end

  def confirm
    redirect_to account_path(current_account) and return if @status_purchase.nil?
    if params[:member_id]
      current_account.update(epoch_member_id: params[:member_id])
    end
    @status_purchase.update(state: :succeed)
    redirect_to account_status_path(@status_purchase.account, @status_purchase.status)
  end

  private

  def redirect_if_cant_buy!
    @status = Status.find(params[:status_id])
    if @status.nil?
      flash[:error] = "Post not found!"
      return redirect_to account_path current_account
    end
    if @status.unlocked_for?(current_account.id)
      flash[:error] = "Already unlocked!"
      redirect_to account_path(status.account)
    end
  end

  def create_pending_status_purchase
    status = Status.find(params[:status_id])

    StatusPurchase.create(
      account: current_account,
      state: :pending,
      status: status,
      amount: status.cost
    )
  end

  def epoch_uri(status, status_purchase)
    if current_account.epoch_member_id.nil?
      DynamicChargeRequestFactory.charge_x(status.cost / 100, status_purchase.id, request.base_url)
    else
      ChargeRequestFactory.new_request(status_purchase.id, status_purchase.amount, current_account.epoch_member_id, account_status_path(status_purchase.account, status_purchase.status), status_purchase_confirm_url(status_purchase.id)).build_uri(Rails.application.credentials[:epoch_hmac])
    end
  end

  def set_status_purchase_by_id
    @status_purchase = StatusPurchase.find(params[:reference_id])
  end
end
