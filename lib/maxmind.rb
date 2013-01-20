require 'active_support'
unless Module.respond_to?(:mattr_accessor)
  require 'active_support/core_ext/module/attribute_accessors'# rescue nil  # this may be needed for ActiveSupport versions >= 3.x
end
require 'active_support/core_ext/hash'
require 'net/http'
require 'net/https'
require 'uri'
require 'digest/md5'

require 'maxmind/version'
require 'maxmind/request'
require 'maxmind/response'