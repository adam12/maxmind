require 'net/https'
require 'uri'
require 'digest/md5'

require 'maxmind/version'
require 'maxmind/request'
require 'maxmind/chargeback_request'
require 'maxmind/chargeback_response'
require 'maxmind/response'

module Maxmind
  SERVERS = %w(minfraud.maxmind.com minfraud-us-east.maxmind.com minfraud-us-west.maxmind.com)
  
  class << self
    attr_accessor :license_key
    attr_accessor :user_id
  end
end
