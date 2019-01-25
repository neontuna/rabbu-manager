require 'oauth2'
require 'httparty'

module Services
  class Smartthings
    ENDPOINTS_URI = 'https://graph.api.smartthings.com/api/smartapps/endpoints'
    OPTIONS = {
      site: 'https://graph.api.smartthings.com',
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token'
    }

    REDIRECT_URI = Rails.application.credentials[Rails.env.to_sym][:st_redirect_uri]
    CLIENT_ID = Rails.application.credentials[Rails.env.to_sym][:st_client_id]
    CLIENT_SECRET = Rails.application.credentials[Rails.env.to_sym][:st_client_secret]

    CLIENT = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, OPTIONS)

    def initialize(listing_id)
      @listing = Listing.find(listing_id)
    end

    def success?
      !failure?
    end

    def failure?
      errors.any?
    end

    def errors
      @errors ||= []
    end

    def authorization_url
      CLIENT.auth_code.authorize_url(
        redirect_uri: REDIRECT_URI, 
        scope: 'app', 
        state: @listing.id
      )
    end

    def auth_token(callback_code)
      handle_http_exception do
        response = CLIENT.auth_code.get_token(callback_code, redirect_uri: REDIRECT_URI, scope: 'app')
        response.token
      end
    end

    def endpoint(auth_token)
      handle_http_exception do
        response = HTTParty.get(
          ENDPOINTS_URI,
          headers: {
            Authorization: "Bearer #{auth_token}"
          }
        )

        if response.code == 200
          response.parsed_response[0]['uri']
        else
          errors << response.parsed_response
        end
      end
    end

    def devices
      handle_http_exception do
        response = HTTParty.get(
          "#{@listing.smartthings_endpoint}/devices",
          headers: {
            Authorization: "Bearer #{@listing.smartthings_token}"
          }
        )

        if response.code == 200
          response.parsed_response
        else
          errors << response.parsed_response
        end
      end    
    end

    def update_devices_for(listing_id)
      devices = get_devices_for(listing_id)
      listing = Listing.find(listing_id)

      devices.each do |remote_device|
        listing.devices.where(smartthings_id: remote_device['id']).first_or_create do |local_device|
          local_device.update(
            display_name: remote_device['name'],
            hardware_type: remote_device['type'],
            status: remote_device['value'],
            meta: remote_device['meta']
          )
        end
      end
    end

    private

    def handle_http_exception
      yield
    rescue HTTParty::Error, SocketError, Net::OpenTimeout, OAuth2::Error => error
      errors << error
    end
  end
end