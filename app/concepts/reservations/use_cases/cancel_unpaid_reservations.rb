module Reservations
  module UseCases
    class CancelUnpaidReservations
      

      def initialize(repository: Reservations::Repository.new)
        @repository = repository

      def call(screening_id)
          reservations = @repository.unpaid(screening_id)
          reservations.map do |reservation|
            client = Clients::Repository.new.find_by(reservation.client_id)
            ReservationMailer.with(reservation: reservation, email: client.email).cancellation_email.deliver_later

            Reservations::UseCases::Delete.new.call(id: reservation.id)

          end
        end
      end
    end
  end
end