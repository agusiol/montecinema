module Reservations
  module UseCases
    class CancelUnpaidReservations
      

      def initialize(screening_id)
        @reservations = Reservations::UseCases::FetchUnpaidReservations.new.call((screening_id))
      end

      def call()
        @reservarions.map do |reservation|
          Reservations::UseCases::Delete.new.call(id: reservation.id)
          
        end
      end
    end
  end
end