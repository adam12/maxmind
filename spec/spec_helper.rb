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

# Constants (classes, etc) defined within a block passed to this method
# will be removed from the global namespace after the block as run.
def isolate_constants
  existing_constants = Object.constants
  yield
ensure
  (Object.constants - existing_constants).each do |constant|
    Object.send(:remove_const, constant)
  end
end


def load_fixture(*filename)
  File.open(File.join('spec', 'data', *filename)).read
end
