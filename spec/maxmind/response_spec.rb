require 'spec_helper'

REQUIRED_FIELDS =

RECOMMENDED_FIELDS =

OPTIONAL_FIELDS =

describe Maxmind::Response do
  before do
    Maxmind.license_key = 'LICENSE_KEY'

    required_fields = JSON.parse(load_fixture("required_fields.json"))
    recommended_fields = JSON.parse(load_fixture("recommended_fields.json"))
    optional_fields = JSON.parse(load_fixture("optional_fields.json"))
    all_fields = required_fields.merge(recommended_fields).merge(optional_fields)
    @response_body = load_fixture("response.txt")

    request = Maxmind::Request.new(all_fields)
    stub_request(:post, "https://minfraud.maxmind.com/app/ccv2r").
      to_return(:body => @response_body, :status => 200)
    @response = request.process!
  end

  it "requires a response" do
    expect { Maxmind::Response.new }.to raise_exception(ArgumentError)
  end

  it "exposes its attributes" do
    @response.attributes.should be_a Hash
  end
  
  it "exposes the raw response body" do
    @response.body.should == @response_body.encode("utf-8", "iso-8859-1")
  end

  it "has a distance" do
    @response.distance.should == 329
  end

  it "has a maxmind ID" do
    @response.maxmind_id.should == '9VSOSDE2'
  end

  it "has a risk score" do
    @response.risk_score.should == 2.0
  end

  it "has a score" do
    @response.score.should == 7.66
  end

  it "has queries remaining" do
    @response.queries_remaining.should == 955
  end

  it "has an explanation" do
    @response.explanation.should be_a String
  end

  it "has a country match" do
    @response.country_match.should_not == nil
  end

  it "has a boolean country match" do
    @response.country_match.should_not == "Yes"
    @response.country_match.should == true
  end

  it "has a phone in billing location" do
    @response.phone_in_billing_location.should == false
  end

  it "has a phone in billing location ? method" do
    @response.phone_in_billing_location?.should == false
  end

  it "has a high risk email" do
    @response.high_risk_email.should == true
  end
end