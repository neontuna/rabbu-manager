require 'oauth2'

class SmartthingsOauthController < ApplicationController
  OPTIONS = {
    site: 'https://graph.api.smartthings.com',
    authorize_url: '/oauth/authorize',
    token_url: '/oauth/token'
  }
  REDIRECT_URI = 'http://localhost:3000/smartthings_oauth/callback'
  CLIENT_ID = Rails.application.credentials[Rails.env.to_sym][:st_client_id]
  CLIENT_SECRET = Rails.application.credentials[Rails.env.to_sym][:st_client_secret]

  def create
    client = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, OPTIONS)
    code = params[:code]

    # Use the code to get the token.
    response = client.auth_code.get_token(code, redirect_uri: REDIRECT_URI, scope: 'app')

    # now that we have the access token, we will store it in the session
    puts "TOKEN #{response.token}"

    # debug - inspect the running console for the
    # expires in (seconds from now), and the expires at (in epoch time)
    puts 'TOKEN EXPIRES IN ' + response.expires_in.to_s
    puts 'TOKEN EXPIRES AT ' + response.expires_at.to_s

    @listing = Listing.find(params[:state])
    if @listing.update(smartthings_token: response.token)
      flash[:success] = "Successfully connected to Smartthings, syncing devices now..."
      redirect_to @listing
    end
  end
end
