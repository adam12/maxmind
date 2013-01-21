require 'net/https'
require 'uri'
require 'digest/md5'

require 'maxmind/version'
require 'maxmind/request'
require 'maxmind/response'

module Maxmind
  SERVERS = %w(minfraud.maxmind.com minfraud-us-east.maxmind.com minfraud-us-west.maxmind.com)
  
  class << self
    attr_accessor :license_key
  end
end
