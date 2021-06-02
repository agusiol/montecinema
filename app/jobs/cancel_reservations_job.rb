class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform
    #find all screenings that will start in 30 minuts or earlier
    screenings  = Screenings::UseCases::FindAll.new.call
    now = Time.zone.now
    screenings.map do |screening|
      if screening.date.to_time - now <= 0.5.hours
        #cancel all unpaid reservation for given screening
        Reservations::UseCases::CancelUnpaidReservations.new.call(screening.id)
      end
    end
  end
end
