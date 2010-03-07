module Maxmind
  # Your license key
  mattr_accessor :license_key
  
  class Request
    # optionally set a default request type (one of 'standard' or 'premium')
    #   Maxmind's default behavior is to use premium if you have credits, else use standard
    mattr_accessor :default_request_type
    
    
    # Required Fields
    attr_accessor :client_ip, :city, :region, :postal, :country
    
    # Optional Fields
    attr_accessor :domain, :bin, :bin_name, :bin_phone, :cust_phone, :request_type,
      :forwarded_ip, :email, :username, :password, :transaction_id, :session_id,
      :shipping_address, :shipping_city, :shipping_region, :shipping_postal,
      :shipping_country, :user_agent, :accept_language
    
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
      @email = Digest::MD5.hexdigest(email.downcase)
      self.domain = email unless domain
    end
    
    def username=(username)
      @username = Digest::MD5.hexdigest(username.downcase)
    end
    
    def password=(password)
      @password = Digest::MD5.hexdigest(password.downcase)
    end
    
    # if a full card number is passed, grab just the first 6 digits (which is the bank id number)
    def bin=(bin)
      @bin = bin ? bin[0,6] : nil
    end
    
    
    def process!
      resp = post(query)
      Maxmind::Response.new(resp)
    end
    
    def process
      process!
    rescue Exception => e
      false
    end
    
    
    private
    
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
        :requested_type   => @request_type || @@default_request_type,
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
        :accept_language  => @accept_langage
      }
      
      field_set = required_fields.merge(optional_fields)
      field_set.reject {|k, v| v.nil? }#.to_query
    end
    
    # Upon a failure at the first URL, will automatically retry with the second one before finally raising an exception
    def post(query_params)
      servers ||= ["https://minfraud1.maxmind.com/app/ccv2r", "https://minfraud3.maxmind.com/app/ccv2r"]
      url = URI.parse(servers.shift)
      
      # req = Net::HTTP::Get.new("#{url.path}?#{query_string}")
      req = Net::HTTP::Post.new("#{url.path}")
      req.set_form_data(query_params)
      h = Net::HTTP.new(url.host, url.port)
      h.use_ssl = true
      h.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = h.start { |http| http.request(req) }
      response.body
      
    rescue Exception => e
      retry if servers.size > 0
      raise e
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