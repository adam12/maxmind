require 'spec_helper'

describe Maxmind::ChargebackRequest do
  before do
    Maxmind.user_id = 'user'
    Maxmind.license_key = 'key'
    @request = Maxmind::ChargebackRequest.new(:client_ip => '198.51.100.2')
  end

  it "requires a License Key" do
    Maxmind.license_key = nil
    expect { @request.send(:validate) }.to raise_error(ArgumentError)
    Maxmind.license_key = 'key'
  end

  it "requires a User ID" do
    Maxmind.user_id = nil
    expect { @request.send(:validate) }.to raise_error(ArgumentError)
    Maxmind.user_id = 'user'
  end

  it "requires a client IP" do
    @request.client_ip = nil
    expect { @request.send(:validate) }.to raise_error(ArgumentError)
  end
end
