# frozen_string_literal: true
require 'singleton'

class ChargeRequestFactory
  include Singleton

  def new_request(cents, member_id, return_url, callback_url)
    ChargeRequest.new({
      'action' => 'authandclose',
      'auth_amount' => cents,
      'description' => 'Testtransaction',
      'currency' => 'USD',
      'member_id' => member_id,
      'returnurl' => return_url,
      'pburl' => callback_url,
    })
  end
end
