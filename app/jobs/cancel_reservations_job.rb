class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform
    #find all screenings that will start in 30 minuts or earlier
    screenigs  = Screenings::UseCases::FindAll.new.call
    now = Time.zone.now
    screenings.map do |screening|
      if screening.date.to_time - now.to_time <= 0.5.hours
        #cancel all unpaid reservation for given screning
        Reservations::UseCases::CancelUnpaidReservations.new(screenng.id).call
      end
    end
  end
end
