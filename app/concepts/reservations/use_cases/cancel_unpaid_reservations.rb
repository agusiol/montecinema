module Reservations
  module UseCases
    class CancelUnpaidReservations
      

      def initialize(repository: Reservations::Repository.new)
        @repository = repository

      def call(screening_id)
          reservations = repository.unpaid(screening_id)
          reservarions.map do |reservation|
            Reservations::UseCases::Delete.new.call(id: reservation.id)
          end
        end
      end
    end
  end
end