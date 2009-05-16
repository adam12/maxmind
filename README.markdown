maxmind
=======

Interfaces with Maxmind's minFraud anti-fraud service.

Installation
------------
	gem install adam12-maxmind --source=http://gems.github.com
	

Dependencies
------------
* [httparty](http://github.com/jnunemaker/httparty/)
* [shoulda](http://github.com/thoughtbot/shoulda/) (used in tests only)
* [matchy](http://github.com/jeremymcanally/matchy/) (used in tests only)


Usage
-----

### Minimum Required ###
These are the only required fields to acquire a response from Maxmind.

	request = Maxmind::Request.new('LICENSE_KEY',
		:client_ip => '24.24.24.24',
		:city => 'New York',
		:region	=> 'NY',
		:postal	=> '11434',
		:country => 'US')
		
	response = Maxmind::Response.new(request.query)


### Recommended ###
For increased accuracy, these are the recommended fields to submit to Maxmind. The additional
fields here are optional and can be all or none.

	request = Maxmind::Request.new('LICENSE_KEY',
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
	  	:password => 'test_carder_password')
	
	response = Maxmind::Response.new(request.query)

### Thorough ###

	request = Maxmind::Request.new('LICENSE_KEY',
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
		:requested_type => 'premium',
		:shipping_address => '145-50 157th Street',
		:shipping_city => 'Jamaica',
		:shipping_region => 'NY',
		:shipping_postal => '11434',
		:shipping_country => 'US',
		:transaction_id => '1234',
		:session_id => 'abcd9876',
		:user_agent => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; en-us) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.2 Safari/525.20.1',
		:accept_language => 'en-us')
		
	response = Maxmind::Response.new(request.query)

Also see examples/example.rb


Reference
---------
[minFraud API Reference](http://www.maxmind.com/app/ccv)


Copyright
---------
Copyright (c) 2009 Adam. See LICENSE for details.
