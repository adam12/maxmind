require 'test_helper'

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
  :requested_type => 'premium',
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

class MaxmindTest < Test::Unit::TestCase
  context "New Request object" do
    setup do
      @request = Maxmind::Request.new('key', REQUIRED_FIELDS)
    end
    
    should "require a key" do
      lambda { Maxmind::Request.new }.should raise_error(ArgumentError)
      
      Maxmind::Request.new('key').license_key.should == 'key'
    end
    
    should "require client IP" do
      lambda { @request.client_ip = nil; @request.query }.should raise_error(ArgumentError)
    end
    
    should "require city" do
      lambda { @request.city = nil; @request.query }.should raise_error(ArgumentError)
    end
    
    should "require region" do
      lambda { @request.region = nil; @request.query }.should raise_error(ArgumentError)
    end
    
    should "require postal" do
      lambda { @request.postal = nil; @request.query }.should raise_error(ArgumentError)
    end
    
    should "require country" do
      lambda { @request.country = nil; @request.query }.should raise_error(ArgumentError)
    end
    
    should "convert username to MD5" do
      @request.username = 'testuser'
      @request.username.should == '5d9c68c6c50ed3d02a2fcf54f63993b6'
    end
    
    should "convert password to MD5" do
      @request.password = 'testpassword'
      @request.password.should == 'e16b2ab8d12314bf4efbd6203906ea6c'
    end
    
    should "convert email to MD5" do
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
    setup do
      request = Maxmind::Request.new('LICENSE_KEY', REQUIRED_FIELDS.merge(RECOMMENDED_FIELDS).merge(OPTIONAL_FIELDS))     
      FakeWeb.register_uri(:get, "https://minfraud1.maxmind.com/app/ccv2r?" + request.query(true), :body => File.read(File.join(File.dirname(__FILE__), "fixtures/response.txt")))
      
      @response = Maxmind::Response.new(request.query) 
    end
    
    should "require a response" do
      lambda { Maxmind::Response.new }.should raise_error(ArgumentError)
    end
    
    should "have a distance" do
      @response.distance.should == 329
    end
    
    should "have a maxmind ID" do
      @response.maxmind_id.should == '9VSOSDE2'
    end
    
    should "have a risk score" do
      @response.risk_score.should == 2.0
    end
    
    should "have a score" do
      @response.score.should == 7.66
    end
    
    should "have queries remaining" do
      @response.queries_remaining.should == 955
    end
    
    should "have an explanation" do
      @response.explanation.should_not == nil
    end
  end
end
