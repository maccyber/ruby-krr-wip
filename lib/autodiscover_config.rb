# frozen_string_literal: true

def autodiscover_config(url)
  well_known_url = url + '/.well-known/openid-configuration'
  HTTParty.get(well_known_url).parsed_response
end
