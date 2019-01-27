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
      http_request(ENDPOINTS_URI, :get)[0]['uri']
    end

    # def update_devices_for_listing
    #   return if failure?

    #   devices.each do |remote_device|
    #     @listing.devices.where(smartthings_id: remote_device['id']).first_or_create.tap do |local_device|
    #       local_device.update(
    #         display_name: remote_device['name'],
    #         hardware_type: remote_device['type'],
    #         status: remote_device['value'],
    #         meta: remote_device['meta']
    #       )
    #     end
    #   end

    #   remove_unselected_devices
    # end

    def turn_off_lights_for_listing
      http_request("#{@listing.smartthings_endpoint}/switches/off", :put)
    end

    private

    # check results from Smartthings endpoint, removing any devices that didn't come back
    # we assume the user has unchecked these from the Smartapp install screen
    # def remove_unselected_devices
    #   local_devices = @listing.devices.pluck(:smartthings_id)
    #   remote_devices = devices.collect{ |u| u['id'] }

    #   deleted_ids = local_devices - remote_devices
    #   @listing.devices.where(smartthings_id: deleted_ids).destroy_all
    # end

    # def devices
    #   @devices ||= http_request("#{@listing.smartthings_endpoint}/devices", :get)  
    # end

    def http_request(url, verb)
      handle_http_exception do
        response = HTTParty.send(verb,
          url,
          headers: {
            Authorization: "Bearer #{@listing.smartthings_token}"
          }
        )

        if response.code == 200
          response.parsed_response
        else
          errors << response.parsed_response
          nil
        end
      end    
    end

    def handle_http_exception
      yield
    rescue HTTParty::Error, SocketError, Net::OpenTimeout, OAuth2::Error => error
      errors << error
    end
  end
end