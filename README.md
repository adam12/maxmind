maxmind
==========

A wrapper around MaxMind's minFraud anti-fraud service.

This re-jigs earlier maxmind wrappers to use up-to-date test gems.

It now works with Ruby 1.9

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
A `Gemfile` pointing to `gemspec` has been added so that bundler can be used to update dependencies. Just run

    bundler install

Running Tests
-------------

Run `bundle install` to make sure you have all the dependencies. In some cases it may be necessary to install
ActiveSupport by hand, `gem install activesupport`. Once that's done, run:

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


Also see examples/example.rb

TODO
----

The specs have been updated from earlier versions, but still aren't comprehensive.

Eg, it would be nice to test that server failover actually works.

Reference
---------
[minFraud API Reference](http://www.maxmind.com/app/ccv)

Copyright
---------
Copyright (c) 2009 Adam.
Copyright (c) 2010 t.e.morgan.
See LICENSE for details.
