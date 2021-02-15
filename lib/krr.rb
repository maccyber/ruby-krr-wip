# frozen_string_literal: true

require 'httparty'
require 'jwt'
require 'securerandom'
require './lib/clean_cert'
require './lib/autodiscover_config'

# Class description
class KRR
  def initialize(url, public_cert, private_key, issuer, scope)
    url = url.chomp('/')
    openid_config = autodiscover_config(url)

    @url = url
    @public_cert = public_cert
    @private_key = private_key
    @issuer = issuer
    @scope = scope
    @audience = openid_config['issuer']
    @token_endpoint = openid_config['token_endpoint']
  end

  def retrive_data(payload)
    create_jwt
    retrive_token
    url = @url + '/kontaktinfo-oauth2-server/rest/v1/personer'
    HTTParty.post(url, body: payload, headers: { Authorization: "Bearer #{@token}", 'Content-type': 'application/json' }).parsed_response
    raise "Error #{response.parsed_response}" unless response.code.to_i == 200
  end

  private

  def create_jwt
    payload = {
      jti: SecureRandom.uuid,
      aud: @audience,
      iss: @issuer,
      iat: Time.now.to_i,
      exp: Time.now.to_i + 120,
      scope: @scope
    }

    @jwt = JWT.encode(payload, @private_key, 'RS256', x5c: [clean_cert(@public_cert)])
  end

  def retrive_token
    payload = "grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=#{@jwt}"
    response = HTTParty.post(@token_endpoint, body: payload, headers: { 'Content-type': 'application/x-www-form-urlencoded' })
    raise "Error #{response.parsed_response}" unless response.code.to_i == 200

    @token = response.parsed_response['access_token']
  end

end
