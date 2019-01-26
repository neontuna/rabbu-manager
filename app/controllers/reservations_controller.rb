class ReservationsController < ApplicationController
  def create
    @listing = current_user.listings.find(params[:listing_id])
    redirect_to root, warning: 'Invalid listing id' unless @listing
    
    @reservation = @listing.reservations.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.js { redirect_to @listing, notice: 'Reservation was successfully created.' }
      else
        format.js { render :create, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @listing = current_user.listings.find(params[:listing_id])
    redirect_to root, warning: 'Invalid listing id' unless @listing

    @reservation = @listing.reservations.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @listing = current_user.listings.find(params[:listing_id])
    redirect_to root, warning: 'Invalid listing id' unless @listing
    
    @reservation = @listing.reservations.find(params[:id])

    respond_to do |format|
      if @reservation.update(reservation_params)
        format.js { redirect_to @listing, notice: 'Reservation was successfully updated.' }
      else
        format.js { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing = current_user.listings.find(params[:listing_id])
    redirect_to root, warning: 'Invalid listing id' unless @listing
    
    @reservation = @listing.reservations.find(params[:id])

    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to @listing, notice: 'Reservation was successfully destroyed.' }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
