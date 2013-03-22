module Maxmind
  class Request
    DefaultTimeout = 60

    # optionally set a default request type (one of 'standard' or 'premium')
    #   Maxmind's default behavior is to use premium if you have credits, else use standard
    class << self
      attr_accessor :default_request_type
      attr_accessor :timeout
    end

    # Required Fields
    attr_accessor :client_ip, :city, :region, :postal, :country

    # Optional Fields
    attr_accessor :domain, :bin, :bin_name, :bin_phone, :cust_phone, :request_type,
      :forwarded_ip, :email, :username, :password, :transaction_id, :session_id,
      :shipping_address, :shipping_city, :shipping_region, :shipping_postal,
      :shipping_country, :user_agent, :accept_language, :order_amount,
      :order_currency, :avs_result, :cvv_result, :txn_type

    def initialize(attrs={})
      self.attributes = attrs
    end

    def attributes=(attrs={})
      attrs.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    # email domain ... if a full email is provided, take just the domain portion
    def domain=(email)
      @domain = if email =~ /@(.+)/
        $1
      else
        email
      end
    end

    # customer email ... sends just an MD5 hash of the email.
    # also sets the email domain at the same time.
    def email=(email)
      @email = md5_digest(email)
      self.domain = email unless domain
    end

    def username=(username)
      @username = md5_digest(username)
    end

    def password=(password)
      @password = md5_digest(password)
    end

    # if a full card number is passed, grab just the first 6 digits (which is the bank id number)
    def bin=(bin)
      @bin = bin ? bin[0,6] : nil
    end

    def process!
      resp = post(query)
      Maxmind::Response.new(resp.body.encode("utf-8", "iso-8859-1"), resp.code)
    end

    def process
      process!
    rescue Exception => e
      false
    end

    def query
      validate

      required_fields = {
        :i                => @client_ip,
        :city             => @city,
        :region           => @region,
        :postal           => @postal,
        :country          => @country,
        :license_key      => Maxmind::license_key
      }

      optional_fields = {
        :domain           => @domain,
        :bin              => @bin,
        :binName          => @bin_name,
        :binPhone         => @bin_phone,
        :custPhone        => @cust_phone,
        :requested_type   => @request_type || self.class.default_request_type,
        :forwardedIP      => @forwarded_ip,
        :emailMD5         => @email,
        :usernameMD5      => @username,
        :passwordMD5      => @password,
        :shipAddr         => @shipping_address,
        :shipCity         => @shipping_city,
        :shipRegion       => @shipping_region,
        :shipPostal       => @shipping_postal,
        :shipCountry      => @shipping_country,
        :txnID            => @transaction_id,
        :sessionID        => @session_id,
        :user_agent       => @user_agent,
        :accept_language  => @accept_language,
        :avs_result       => @avs_result,
        :cvv_result       => @cvv_result,
        :txn_type         => @txn_type,
        :order_amount     => @order_amount
      }

      field_set = required_fields.merge(optional_fields)
      field_set.reject {|k, v| v.nil? }
    end

    private

    # Upon a failure at the first URL, will automatically retry with the
    # second & third ones before finally raising an exception
    # Returns an HTTPResponse object
    def post(query_params)
      servers ||= SERVERS.map{|hostname| "https://#{hostname}/app/ccv2r"}
      url = URI.parse(servers.shift)
      
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data(query_params)

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

    def md5_digest(value)
      if value =~ /^[0-9a-f]{32}$/i
        value
      else
        Digest::MD5.hexdigest(value.downcase)
      end
    end
    
    protected
    def validate
      raise ArgumentError, 'License key is required' unless Maxmind::license_key
      raise ArgumentError, 'IP address is required' unless client_ip
      raise ArgumentError, 'City is required' unless city
      raise ArgumentError, 'Region is required' unless region
      raise ArgumentError, 'Postal code is required' unless postal
      raise ArgumentError, 'Country is required' unless country
    end
  end
end
