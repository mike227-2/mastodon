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
    unless current_account.has_billing_details?
      flash[:error] = "Billing details incomplete!"
      return redirect_to settings_profile_path current_account
    end
    if @status.unlocked_for?(current_account)
      flash[:error] = "Already unlocked!"
      return redirect_to account_path(status.account)
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
    DynamicChargeRequestFactory.charge_x(status.cost / 100, status_purchase.id, request.base_url)
  end

  def set_status_purchase_by_id
    @status_purchase = StatusPurchase.find(params[:reference_id])
  end
end
