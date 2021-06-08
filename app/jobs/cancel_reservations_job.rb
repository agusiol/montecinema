class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform
    # find all screenings that will start in 30 minuts or earlier
    screenings = Screenings::Repository.new.thirty_minutes_from_now

    screenings.map do |screening|
      # cancel all unpaid reservation for given screening
      Reservations::UseCases::CancelUnpaidReservations.new.call(screening.id)
    end
  end
end
