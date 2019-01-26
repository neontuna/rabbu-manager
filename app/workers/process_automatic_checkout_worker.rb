class ProcessAutomaticCheckoutWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options retry: 3

  sidekiq_retry_in do |count|
    3 * (count + 1) # (i.e. 3, 6, 9)
  end

  sidekiq_retries_exhausted do |msg, ex|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(reservation_id)
    reservation = Reservation.find(reservation_id) 
    reservation.listing.process_automatic_checkout
    reservation.update(automatic_checkout_complete: true)
  end
end
