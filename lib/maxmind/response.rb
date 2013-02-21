module Maxmind
  class Response
    attr_accessor :attributes
    attr_reader :body

    ATTRIBUTE_MAP = {
      'custPhoneInBillingLoc' => 'phone_in_billing_location',
      'maxmindID' => 'maxmind_id',
      'isTransProxy' => 'is_transparent_proxy',
      'err' => 'error',
      'carderEmail' => 'high_risk_email'
    }

    def initialize(response = nil)
      raise ArgumentError, 'Missing response string' unless response
      @body = response
      @attributes = {}
      parse(response)
    end

    def parse(response)
      response.split(';').each do |parameter|
        k, v = parameter.split('=')

        if ATTRIBUTE_MAP.has_key?(k)
          set_attribute(ATTRIBUTE_MAP[k], v)
        else
          set_attribute(k.gsub(/([A-Z])/, '_\1').downcase, v)
        end
      end
    end

    # Returns an array of names for the attributes available
    # on this object sorted alphabetically.
    def attribute_names
      attributes.keys.sort
    end

    def method_missing(meth, *args)
      if meth.to_s[-1] == '?'
        send(meth[0..-2])
      elsif attributes.has_key?(meth)
        attributes[meth]
      else
        super
      end
    end

    def respond_to?(meth)
      if meth.to_s[-1] == '?'
        respond_to? meth[0..-2]
      else
        super
      end 
    end

    protected
    
    def set_attribute(k, v)
      k = k.to_sym

      if v.nil?
        attributes[k] = nil
        return
      end

      v = Integer(v) rescue Float(v) rescue v;

      case v
      when 'Yes', 'yes'
        attributes[k] = true
      when 'No', 'no'
        attributes[k] = false
      else
        attributes[k] = v
      end
    end
  end
end