require 'openssl'
require 'active_support/all'

class ChargeRequest
  attr_accessor :hash

  def initialize(request_hash)
    @hash = base_hash.merge(request_hash)
  end

  def build_uri(hmac)
    "#{EpochConstants.API_URL(nil)}?#{@hash.to_query}&epoch_digest=#{build_digest(hmac)}"
  end

  def build_digest(hmac)
    sorted = @hash.sort_by { |key| key }.to_h
    stringified = ''
    sorted.each do |param|
      stringified = "#{stringified}#{param[0]}#{param[1]}"
    end
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), hmac, stringified)
  end

  private

  def base_hash
    {
      'api' => 'camcharge',
      'action' => 'authandclose',
      'x_epochCamcharge' => 1,
    }
  end
end
