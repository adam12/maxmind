module Maxmind
  class ChargebackRequest
    DefaultTimeout = 60

    # optionally set a default request type (one of 'standard' or 'premium')
    #   Maxmind's default behavior is to use premium if you have credits, else use standard
    class << self
      attr_accessor :default_request_type
      attr_accessor :timeout
    end

    # Required Fields
    attr_accessor :client_ip

    # Optional Fields
    attr_accessor :chargeback_code, :fraud_score, :maxmind_id, :transaction_id

    def initialize(attrs={})
      self.attributes = attrs
    end

    def attributes=(attrs={})
      attrs.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def process!
      resp = post(query)
      Maxmind::ChargebackResponse.new(resp.message,resp.code)
    end

    def process
      process!
    rescue Exception => e
      false
    end

    def query
      validate

      required_fields = {
        :ip_address       => @client_ip,
      }

      optional_fields = {
        :chargeback_code  => @chargeback_code,
        :fraud_score      => @fraud_score,
        :maxmind_id       => @maxmind_id,
        :transaction_id   => @transaction_id
      }

      field_set = required_fields.merge(optional_fields)
      field_set.reject {|k, v| v.nil? }.to_json
    end

    private

    # Upon a failure at the first URL, will automatically retry with the
    # second & third ones before finally raising an exception
    # Returns an HTTPResponse object
    def post(query_params)
      servers ||= SERVERS.map{|hostname| "https://#{hostname}/minfraud/chargeback"}
      url = URI.parse(servers.shift)

      req = Net::HTTP::Post.new(url.path, initheader = {'Content-Type' =>'application/json'})
      req.basic_auth Maxmind::user_id, Maxmind::license_key
      req.body = query_params

      h = Net::HTTP.new(url.host, url.port)
      h.use_ssl = true
      h.verify_mode = OpenSSL::SSL::VERIFY_NONE

      # set some timeouts
      h.open_timeout  = 60 # this blocks forever by default, lets be a bit less crazy.
      h.read_timeout  = self.class.timeout || DefaultTimeout
      h.ssl_timeout   = self.class.timeout || DefaultTimeout

      h.start { |http| http.request(req) }

    rescue Exception => e
      retry if servers.size > 0
      raise e
    end

    protected
    def validate
      raise ArgumentError, 'License key is required' unless Maxmind::license_key
      raise ArgumentError, 'User ID is required' unless Maxmind::user_id
      raise ArgumentError, 'IP address is required' unless client_ip
    end
  end
end
