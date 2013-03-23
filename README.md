maxmind
==========

A wrapper around MaxMind's minFraud anti-fraud service.


Installation
------------

In your Gemfile;

    gem 'maxmind'

Tests
------------

    bundle install
    guard

Dependencies
------------

    bundle install

Running Tests
-------------

Run `bundle install` to make sure you have all the dependencies. Once that's done, run:

    rake test

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

TODO
----
* Improve specs (eg, test server failover)

Reference
---------
[minFraud API Reference](http://www.maxmind.com/app/ccv)

Also see examples/example.rb

Chargeback Service
------------------

You can help improve the Minfraud service by reporting instances of fraud.  Only the IP address of a suspected fraudulent order is required, but you can pass additional information.  Note that your Maxmind User ID is required in addition to your license key.

Chargeback Service Usage
------------------------

### Minimum Required ###
These are the only required fields to acquire a response from MaxMind.

    require 'maxmind'
    Maxmind.license_key = 'LICENSE_KEY'
    Maxmind.user_id     = 'MAXMIND_USER_ID'
    request = Maxmind::ChargebackRequest.new(
      :client_ip => '24.24.24.24'
    )

	  response = request.process!


### Recommended ###
For increased accuracy, these are the recommended fields to submit to MaxMind. The additional
fields here are optional and can be all or none.

    require 'maxmind'
    Maxmind.license_key = 'LICENSE_KEY'
    Maxmind.user_id     = 'MAXMIND_USER_ID'
    request = Maxmind::ChargebackRequest.new(
		  :client_ip       => '24.24.24.24',
      :chargeback_code => 'Fraud',
      :fraud_score     => 'suspected_fraud',
      :maxmind_id      => 'KW36L83C',
      :transaction_id  => '12345'
    )

	  response = request.process!

[minFraud Chargeback reference](http://dev.maxmind.com/minfraud/chargeback)

Contributors
------------
* Sam Oliver <sam@samoliver.com>
* Nick Wilson <nick@di.fm>
* Wolfram Arnold <wolfram@rubyfocus.biz>
* Jonathan Lim <snowblink@gmail.com>
* Tom Blomfield
* Thomas Morgan
* Tinu Cleatus <tinu.cleatus@me.com>
* Don Pflaster <dpflaster@gmail.com>

Thanks to all :)

Copyright
---------
Copyright (c) 2009 Adam Daniels <adam@mediadrive.ca>.

See LICENSE for details.
