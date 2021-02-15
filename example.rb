# frozen_string_literal: true

require './lib/krr'
require 'openssl'

private_key = OpenSSL::PKey::RSA.new(File.read('data/private.key'))
public_cert = OpenSSL::X509::Certificate.new(File.read('data/public.pem')).to_s

krr_instance = KRR.new('https://oidc-ver1.difi.no', public_cert, private_key, 'oidc_user', 'global/kontaktinformasjon.read')
pp krr_instance.retrive_data(personidentifikatorer: ['23079422568'])
