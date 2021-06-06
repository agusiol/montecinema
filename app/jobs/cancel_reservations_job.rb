class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform
    #find all screenings that will start in 30 minuts or earlier
    #maybe it can be done in one call? for reasearch
    screenings  = Screenings::Repository.new.today
    now = Time.zone.now
    screenings.map do |screening|
      #this conditions needs some verification, Time.zone.now is a problem?
      if (screening.date.to_time - now)/60 <= 30
        #cancel all unpaid reservation for given screening
        Reservations::UseCases::CancelUnpaidReservations.new.call(screening.id)
      end
    end
  end
end
