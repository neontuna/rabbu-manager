class SmartthingsOauthController < ApplicationController


  def create
    # token = get_smartthings_token(params[:code])
    # endpoint = get_smartthings_endpoints(token)
    @listing = Listing.find(params[:state])

    if @listing.save_smartthings_connection(params[:code])
      flash[:success] = "Successfully connected to Smartthings, syncing devices now..."
      redirect_to @listing
    end
  end
end
