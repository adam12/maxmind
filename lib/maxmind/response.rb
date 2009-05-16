module Maxmind
  class Response  
    attr_accessor :country_match, :country_code, :high_risk_country, :distance, 
      :ip_region, :ip_city, :ip_latitude, :ip_longitude, :ip_isp, :ip_org,
      :anonymous_proxy, :proxy_score, :is_transparent_proxy,
      :free_mail, :carder_email, :high_risk_username, :high_risk_password,
      :bin_match, :bin_country, :bin_name_match, :bin_name, :bin_phone_match,
      :bin_phone, :phone_in_billing_location, :ship_forward, :city_postal_match,
      :ship_city_postal_match, :score, :explanation, :risk_score, :queries_remaining,
      :maxmind_id, :error, :response
  
    def initialize(response = nil)
      raise ArgumentError, 'need a valid response string' if response.nil?
    
      parse(response)
    end
      
    def parse(response)
      response.split(';').each do |parameter|
        k, v = parameter.split('=')
      
        case k
        when 'err'
          set_attribute('error', v)
        when 'custPhoneInBillingLoc'
          set_attribute('phone_in_billing_location', v)
        when 'maxmindID'
          set_attribute('maxmind_id', v)
        when 'isTransProxy'
          set_attribute('is_transparent_proxy', v)
        when 'explanation'
          @explanation = v
        else
          set_attribute(k.gsub(/([A-Z])/, '_\1').downcase, v)
        end
      end
    end   
  
    alias_method :country_match?, :country_match
    alias_method :high_risk_country?, :high_risk_country
    alias_method :anonymous_proxy?, :anonymous_proxy
    alias_method :is_transparent_proxy?, :is_transparent_proxy
    alias_method :free_mail?, :free_mail
    alias_method :carder_email?, :carder_email
    alias_method :high_risk_username?, :high_risk_username
    alias_method :high_risk_password?, :high_risk_password
    alias_method :city_postal_match?, :city_postal_match
    alias_method :ship_city_postal_match?, :ship_city_postal_match 
    alias_method :bin_match?, :bin_match
  
    protected
    def set_attribute(k, v)      
      if v.nil?
        self.instance_variable_set("@#{k}", nil) 
        return
      end
      
      v = Integer(v) rescue Float(v) rescue v;
      
      case v
      when /[Yy]es/
        self.instance_variable_set("@#{k}", true)
      when /[Nn]o/
        self.instance_variable_set("@#{k}", false)
      else
        self.instance_variable_set("@#{k}", v)
      end
    end    
  end
end