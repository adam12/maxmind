require 'spec_helper'

REQUIRED_FIELDS = {
  :client_ip => '24.24.24.24',
  :city => 'New York',
  :region => 'NY',
  :postal => '11434',
  :country => 'US'
}

RECOMMENDED_FIELDS = {
  :domain => 'yahoo.com',
  :bin => '549099',
  :forwarded_ip => '24.24.24.25',
  :email => 'test@test.com',
  :username => 'test_carder_username',
  :password => 'test_carder_password'
}

OPTIONAL_FIELDS = {
  :bin_name => 'MBNA America Bank',
  :bin_phone => '800-421-2110',
  :cust_phone => '212-242',
  :request_type => 'premium',
  :shipping_address => '145-50 157th Street',
  :shipping_city => 'Jamaica',
  :shipping_region => 'NY',
  :shipping_postal => '11434',
  :shipping_country => 'US',
  :transaction_id => '1234',
  :session_id => 'abcd9876',
  :user_agent => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; en-us) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.2 Safari/525.20.1',
  :accept_language => 'en-us'
}

describe Maxmind::Responde < Test::Unit::TestCase
  context "New Request object" do
    before do
      Maxmind.license_key = 'key'
      @request = Maxmind::Request.new(REQUIRED_FIELDS)
    end

    it "requires a key" do
      Maxmind.license_key = nil
      lambda { @request.send(:validate) }.should raise_error(ArgumentError)
      Maxmind.license_key = 'key'
    end

    it "requires client IP" do
      lambda { @request.client_ip = nil; @request.send(:validate) }.should raise_error(ArgumentError)
    end

    it "requires city" do
      lambda { @request.city = nil; @request.send(:validate) }.should raise_error(ArgumentError)
    end

    it "requires region" do
      lambda { @request.region = nil; @request.send(:validate) }.should raise_error(ArgumentError)
    end

    it "requires postal" do
      lambda { @request.postal = nil; @request.send(:validate) }.should raise_error(ArgumentError)
    end

    it "requires country" do
      lambda { @request.country = nil; @request.send(:validate) }.should raise_error(ArgumentError)
    end

    it "converts username to MD5" do
      @request.username = 'testuser'
      @request.username.should == '5d9c68c6c50ed3d02a2fcf54f63993b6'
    end

    it "converts password to MD5" do
      @request.password = 'testpassword'
      @request.password.should == 'e16b2ab8d12314bf4efbd6203906ea6c'
    end

    it "converts email to MD5" do
      @request.email = 'test@test.com'
      @request.email.should == 'b642b4217b34b1e8d3bd915fc65c4452'
    end
  end

  #context "Requesting" do
  #  setup do
  #    request = Maxmind::Request.new('LICENSE_KEY', REQUIRED_FIELDS.merge(RECOMMENDED_FIELDS).merge(OPTIONAL_FIELDS))
  #    FakeWeb.register_uri(:get, "http://minfraud3.maxmind.com/app/ccv2r?" + request.query(true), :string => File.read(File.join(File.dirname(__FILE__), "fixtures/basic.txt")))
  #
  #    @response = Maxmind::Response.new(request)
  #  end
  #end

  context "Response" do
    before do
      Maxmind.license_key = 'LICENSE_KEY'
      request = Maxmind::Request.new(REQUIRED_FIELDS.merge(RECOMMENDED_FIELDS).merge(OPTIONAL_FIELDS))
      FakeWeb.register_uri(:post, "https://minfraud1.maxmind.com/app/ccv2r", :body => File.read(File.join(File.dirname(__FILE__), "fixtures/response.txt")))

      @response = request.process!
    end

    it "requires a response" do
      lambda { Maxmind::Response.new }.should raise_error(ArgumentError)
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
      @response.explanation.should_not == nil
    end
  end
end
