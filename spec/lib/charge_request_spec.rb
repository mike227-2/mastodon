require 'lib_spec_helper'

RSpec.describe ChargeRequest do
  it 'digest generation' do

    request_hash = {
      'auth_amount' => 20,
      'returnurl' => 'https://httpdump.io/hvtmo',
      'pburl' => 'https://webhook.site/#!/9c4dab51-a8d3-4636-92ca-3eae15c296bd',
      'description' => 'Description',
      'member_id' => 1
    }
    charge_request = ChargeRequest.new(request_hash)

    digest_actual = charge_request.build_digest('testkey')

    expect(digest_actual).to eq "f3c33c328e7905e0440aff3d9f629787"
  end
  it 'uri generation' do
    request_hash = {
      'auth_amount' => 20,
      'member_id' => 1
    }

    charge_request = ChargeRequest.new(request_hash)

    expect(charge_request.build_uri('testkey')).to eq("https://wnu.com/secure/services?action=authandclose&api=camcharge&auth_amount=20&member_id=1&x_epochCamcharge=1&epoch_digest=4317409081dc3683421569b0228fcbc7")
  end
end
