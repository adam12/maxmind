maxmind-rb
==========

A wrapper around MaxMind's minFraud anti-fraud service.

This is a rewrite of earlier maxmind wrappers. Works with Ruby 1.9

Installation
------------

	TBD


Dependencies
------------
* active_support
* rspec
* mocha


Usage
-----

### Minimum Required ###
These are the only required fields to acquire a response from MaxMind.

    require 'maxmind'
    Maxmind.license_key = 'LICENSE_KEY'
    request = Maxmind::Request.new(
      :client_ip => '24.24.24.24',
      :city => 'New York',
      :region	=> 'NY',
      :postal	=> '11434',
      :country => 'US'
    )

	  response = request.process!


### Recommended ###
For increased accuracy, these are the recommended fields to submit to MaxMind. The additional
fields here are optional and can be all or none.

    require 'maxmind'
    Maxmind.license_key = 'LICENSE_KEY'
    request = Maxmind::Request.new(
		  :client_ip => '24.24.24.24',
		  :city => 'New York',
		  :region	=> 'NY',
		  :postal	=> '11434',
		  :country => 'US',
		  :domain => 'yahoo.com',
      :bin => '549099',
      :forwarded_ip => '24.24.24.25',
      :email => 'test@test.com',
      :username => 'test_carder_username',
      :password => 'test_carder_password'
    )

	  response = request.process!

### Thorough ###
This is every field available.

    require 'maxmind'
    Maxmind.license_key = 'LICENSE_KEY'
    request = Maxmind::Request.new(
      :client_ip => '24.24.24.24',
      :city => 'New York',
      :region	=> 'NY',
      :postal	=> '11434',
      :country => 'US',
      :domain => 'yahoo.com',
      :bin => '549099',
      :forwarded_ip => '24.24.24.25',
      :email => 'test@test.com',
      :username => 'test_carder_username',
      :password => 'test_carder_password'
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
    )

	  response = request.process!


Also see examples/example.rb


Reference
---------
[minFraud API Reference](http://www.maxmind.com/app/ccv)


Copyright
---------
Copyright (c) 2009 Adam.
Copyright (c) 2010 t.e.morgan.
See LICENSE for details.
