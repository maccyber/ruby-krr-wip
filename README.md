# krr

Module for authenticate with oauth2 and retreiving data from kontakt- og reservasjonsregisteret

### Example

```ruby
# frozen_string_literal: true

require 'krr'
require 'openssl'

private_key_file = File.read('data/private.key')
public_cert_file = File.read('data/public.pem')
private_key = OpenSSL::PKey::RSA.new(private_key_file)
public_cert = OpenSSL::X509::Certificate.new(public_cert_file).to_s

krr_instance = KRR.new('https://oidc-ver1.difi.no', public_cert, private_key, 'oidc_user', 'global/kontaktinformasjon.read')
pp krr_instance.retrive_data(personidentifikatorer: ['23079422568'])
```

### LICENSE

[MIT](LICENSE)
