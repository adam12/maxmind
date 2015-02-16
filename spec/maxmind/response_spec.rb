require 'spec_helper'

describe Maxmind::Response do
  before do
    Maxmind.license_key = 'LICENSE_KEY'

    required_fields = JSON.parse(load_fixture("required_fields.json"))
    recommended_fields = JSON.parse(load_fixture("recommended_fields.json"))
    optional_fields = JSON.parse(load_fixture("optional_fields.json"))
    all_fields = required_fields.merge(recommended_fields).merge(optional_fields)
    @response_body = load_fixture("response.txt")
    @response_body.encode!("utf-8", "iso-8859-1") if @response_body.respond_to?(:encode!)

    request = Maxmind::Request.new(all_fields)
    stub_request(:post, "https://minfraud.maxmind.com/app/ccv2r").
      to_return(:body => @response_body, :status => 200)
    @response = request.process!
  end

  it "requires a response" do
    expect { Maxmind::Response.new }.to raise_exception(ArgumentError)
  end

  it "exposes its attributes" do
    expect(@response.attributes).to be_a Hash
  end

  it "exposes the raw response body" do
    expect(@response.body).to eq @response_body
  end

  it "exposes the http response code" do
    expect(@response.http_code).to eq 200
  end

  it "has a distance" do
    expect(@response.distance).to eq 329
  end

  it "has a maxmind ID" do
    expect(@response.maxmind_id).to eq '9VSOSDE2'
  end

  it "has a risk score" do
    expect(@response.risk_score).to eq 2.0
  end

  it "has a score" do
    expect(@response.score).to eq 7.66
  end

  it "has queries remaining" do
    expect(@response.queries_remaining).to eq 955
  end

  it "has an explanation" do
    expect(@response.explanation).to be_a String
  end

  it "has a country match" do
    expect(@response.country_match).not_to be_nil
  end

  it "has a boolean country match" do
    expect(@response.country_match).not_to eq "Yes"
    expect(@response.country_match).to be_truthy
  end

  it "has a phone in billing location" do
    expect(@response.phone_in_billing_location).to be_falsey
  end

  it "has a phone in billing location ? method" do
    expect(@response.phone_in_billing_location?).to be_falsey
  end

  it "has a high risk email" do
    expect(@response.high_risk_email).to be_truthy
  end
end
