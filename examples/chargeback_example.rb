require 'pp'
require File.join(File.dirname(__FILE__), '..', 'lib/maxmind')

required_fields = {
  :client_ip => '24.24.24.24'
}

recommended_fields = {
  :client_ip       => '24.24.24.24',
  :chargeback_code => 'Fraud',
  :fraud_score     => 'suspected_fraud',
  :maxmind_id      => 'KW36L83C',
  :transaction_id  => '12345'
}

Maxmind.license_key = 'LICENSE_KEY'
Maxmind.user_id     = 'MAXMIND_USER_ID'
request = Maxmind::ChargebackRequest.new(required_fields.merge(recommended_fields))
response = request.process!
pp response
