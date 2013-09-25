require 'spec_helper'

describe Maxmind::ChargebackResponse do
  before do
    Maxmind.user_id = 'USER_ID'
    Maxmind.license_key = 'LICENSE_KEY'

    request = Maxmind::ChargebackRequest.new(:client_ip => '198.51.100.2')
    stub_request(:post, "https://USER_ID:LICENSE_KEY@minfraud.maxmind.com/minfraud/chargeback").
      to_return(:body => '', :status => 200)
    @response = request.process!
  end

  it "requires a response" do
    expect { Maxmind::ChargebackResponse.new }.to raise_exception(ArgumentError)
  end

  it "exposes the http response code" do
    expect(@response.http_code).to eq  200
  end

  it "exposes the http response" do
    expect(@response.response).to_not be_nil
  end
end
