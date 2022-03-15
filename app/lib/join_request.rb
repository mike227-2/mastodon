require 'active_support/all'

class JoinRequest

  def initialize(request_hash)
    @request_hash = request_hash
  end

  def build_uri(hmac)
    "#{EpochConstants.API_URL(nil)}?#{base_hash.merge(@request_hash).to_query}"
  end

  private

  def base_hash
    {
      'api' => 'join',
      'pi_code' => pi_code,
      'reseller' => 'a',
    }
  end

  def pi_code
    '123'
  end
end
