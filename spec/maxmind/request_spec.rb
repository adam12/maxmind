require 'spec_helper'

describe Maxmind::Request do
  before do
    Maxmind.license_key = 'key'
    required_fields = JSON.parse(load_fixture("required_fields.json"))
    @request = Maxmind::Request.new(required_fields)
  end

  it "requires a key" do
    Maxmind.license_key = nil
    expect { @request.send(:validate) }.to raise_error(ArgumentError)
    Maxmind.license_key = 'key'
  end

  it "requires client IP" do
    expect {
      @request.client_ip = nil; @request.send(:validate)
    }.to raise_exception(ArgumentError)
  end

  it "doesn't require city" do
    expect {
      @request.city = nil; @request.send(:validate)
    }.not_to raise_error
  end

  it "doesn't require region" do
    expect {
      @request.region = nil; @request.send(:validate)
    }.not_to raise_error
  end

  it "doesn't require postal" do
    expect {
      @request.postal = nil; @request.send(:validate)
    }.not_to raise_error
  end

  it "doesn't require country" do
    expect {
      @request.country = nil; @request.send(:validate)
    }.not_to raise_error
  end

  it "saves order currency" do
    @request.order_currency = 'GBP'
    expect(@request.query[:order_currency]).to eq 'GBP'
  end

  it "converts username to MD5" do
    @request.username = 'testuser'
    expect(@request.username).to eq '5d9c68c6c50ed3d02a2fcf54f63993b6'
  end

  it "converts password to MD5" do
    @request.password = 'testpassword'
    expect(@request.password).to eq 'e16b2ab8d12314bf4efbd6203906ea6c'
  end

  it "converts email to MD5" do
    @request.email = 'test@test.com'
    expect(@request.email).to eq 'b642b4217b34b1e8d3bd915fc65c4452'
  end

  it "does not double convert an md5 username" do
    @request.username = 'b642b4217b34b1e8d3bd915fc65c4452'
    expect(@request.username).to eq 'b642b4217b34b1e8d3bd915fc65c4452'
  end

  it "does not double convert an md5 password" do
    @request.password = 'b642b4217b34b1e8d3bd915fc65c4452'
    expect(@request.password).to eq 'b642b4217b34b1e8d3bd915fc65c4452'
  end

  it "does not double convert an md5 email" do
    @request.email = 'b642b4217b34b1e8d3bd915fc65c4452'
    expect(@request.email).to eq 'b642b4217b34b1e8d3bd915fc65c4452'
  end

  it "exposes the query parameters" do
    expect(@request.query).to be_a Hash
  end

end
