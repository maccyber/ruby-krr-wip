# frozen_string_literal

Gem::Specification.new do |s|
  s.name = 'krr'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.description = 'Retrive info from KRR'
  s.summary = 'Module for authenticate with oauth2 and retreiving data from kontakt- og reservasjonsregisteret'
  s.authors = ['Jonas Maccyber Enge']
  s.email = 'jonas@rubynor.com'
  s.files = [
    'Gemfile',
    'lib/krr.rb',
    'lib/autodiscover_config.rb',
    'lib/clean_cert.rb'
  ]
  s.require_paths = ['lib']
end
