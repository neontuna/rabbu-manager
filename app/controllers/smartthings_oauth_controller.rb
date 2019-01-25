class SmartthingsOauthController < ApplicationController
  def create
    @listing = Listing.find(params[:state])

    if @listing.save_smartthings_connection(params[:code])
      UpdateDevicesWorker.perform_async(@listing.id)
      flash[:success] = "Successfully connected to Smartthings, syncing devices now..."
    else
      flash[:error] = "There was a problem connecting to Smartthings, please try again."
    end
    
    redirect_to @listing
  end
end
