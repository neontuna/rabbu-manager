class ReservationsController < ApplicationController
  before_action :load_listing
  before_action :load_reservation, except: [:create]

  def create
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
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.js { redirect_to @listing, notice: 'Reservation was successfully updated.' }
      else
        format.js { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to @listing, notice: 'Reservation was successfully destroyed.' }
    end
  end

  private

  def load_listing
    @listing = current_user.listings.find(params[:listing_id])
    redirect_to root, warning: 'Invalid listing id' unless @listing
  end

  def load_reservation
    @reservation = @listing.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
