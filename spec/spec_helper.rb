require 'rubygems'
require 'bundler/setup'

require 'mocha_standalone'
require 'maxmind'
require 'json'
require 'webmock/rspec'

RSpec.configure do |config|

  config.before(:suite) do
    # Disable all live HTTP requests
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  config.mock_with :mocha
end

def load_fixture(*filename)
  File.open(File.join('spec', 'data', *filename)).read
end
