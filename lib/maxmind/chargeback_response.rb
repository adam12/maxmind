module Maxmind
  class ChargebackResponse
    attr_accessor :attributes
    attr_reader :response, :http_code

    def initialize(response = nil, http_code = nil)
      raise ArgumentError, 'Missing response string' unless response
      @response = response
      @http_code = http_code.to_i if http_code
    end
  end
end
