# frozen_string_literal: true
class StatusPurchaseController < ApplicationController
  before_action :redirect_if_cant_buy!
  def new_transaction
    create_pending_status_purchase
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

  def epoch_request(status)
    request = Epoch::ChargeRequest.new

    request.action = 'authandclose'
    request.auth_amount = status.cost
    request.member_id = 123
    request.description = "Post with Id: #{status.id} by: #{status.author.username}"

    "https://test.wnu.com/secure/services?#{request.request.to_query}"
  end
end
