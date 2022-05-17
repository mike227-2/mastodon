# frozen_string_literal: true
class ChargeRequestFactory

  def self.new_request(description, cents, member_id, return_url, callback_url)
    ChargeRequest.new({
      'action' => 'authandclose',
      'auth_amount' => cents,
      'description' => description,
      'currency' => 'USD',
      'member_id' => member_id,
      'returnurl' => return_url,
      'pburl' => callback_url,
    })
  end
end
