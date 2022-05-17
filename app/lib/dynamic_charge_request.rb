require 'json'
require 'jwt'
require 'net/http'

class DynamicChargeRequest
  CLIENT_ID = Rails.application.credentials[:epoch_client_id]
  SHARED_SECRET_KEY = Rails.application.credentials[:epoch_shared_secret]
  API_URL = 'https://join.wnu.com/invoice-push'

  def initialize(invoice, base_url)
    @invoice = invoice
    @success_url = "#{base_url}/confirm/#{invoice.invoice_id}"
  end

  def run
    @invoice.client_id = CLIENT_ID
    @invoice.success_url = @success_url
    payload = @invoice.invoice_attributes.to_json
    authorization_token = create_authorization_token(payload)
    response = Net::HTTP.post(URI(API_URL), payload, 'Authorization' => "Bearer #{authorization_token}", "Content-type" => 'application/json')

    json_content = JSON.parse(response.body)

    if json_content.key? 'success'
      json_content['redirectURL']
    else
      json_content
    end
  end

  private

  def create_authorization_token(payload)
    JWT.encode JSON.parse(payload), SHARED_SECRET_KEY
  end

end
