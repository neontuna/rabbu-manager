task smartthings_update: [:environment] do
  pending_automatic_checkout = Reservation.pending_automatic_checkout
  pending_automatic_checkout.each do |reservation|
    ProcessAutomaticCheckoutWorker.perform_async(reservation.id)
  end
end