require 'pp'
require File.join(File.dirname(__FILE__), '..', 'lib/maxmind')

required_fields = {
  :client_ip => '24.24.24.24', 
  :city => 'New York', 
  :region => 'NY', 
  :postal => '11434', 
  :country => 'US'
}

recommended_fields = {
  :domain => 'yahoo.com',
  :bin => '549099',
  :forwarded_ip => '24.24.24.25',
  :email => 'test@test.com',
  :username => 'test_carder_username',
  :password => 'test_carder_password'
}

optional_fields = {
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

Maxmind.license_key = 'LICENSE_KEY'
Maxmind::Request.default_request_type = 'standard'
request = Maxmind::Request.new(required_fields.merge(recommended_fields).merge(optional_fields))
response = request.process!
pp response
