# frozen_string_literal: true
class StatusPurchaseController < ApplicationController
  before_action :redirect_if_cant_buy!
  def new_transaction
    create_pending_status_purchase
    redirect_to epoch_uri(@status)
  end

  private

  def redirect_if_cant_buy!
    @status = Status.find(params[:status_id])
    if @status.nil?
      return redirect_to account_path current_account
    end
    if @status.unlocked_for?(current_account)
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

  def epoch_uri(status)
    TransactionManager.new(Rails.application.credentials.epoch_hmac).charge_for_status_uri(current_account, status)
  end
end
