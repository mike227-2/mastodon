require 'json'
require 'jwt'
require 'net/http'

class DynamicChargeRequest
  # client_id = mastercode without the 'M-'
  CLIENT_ID = '660268'
  #SHARED_SECRET_KEY= '993f8cb425dfb45ed3b83a4c7718a922'
  SHARED_SECRET_KEY= 'LbWTWEyVMX'
  API_URL = 'https://join.wnu.com/invoice-push'
  #API_URL = 'http://localhost:8080/invoice-push'

  def initialize(invoice)
    @invoice = invoice
  end

  def run
    @invoice.client_id = CLIENT_ID
    payload = @invoice.invoice_attributes.to_json
    authorization_token = create_authorization_token(payload)
    puts authorization_token
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
