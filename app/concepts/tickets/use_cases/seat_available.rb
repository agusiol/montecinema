module Tickets
  module UseCases
    class SeatAvailable
    

      def initialize(reservation_id, seat)
        reservation =  Reservations::Repository.new.find_by(reservation_id)
        @available_seats = Screenings::UseCases::FindAvailableSeats.new(reservation.screening_id).call
        @seat = seat
        
      end

      def call
        @available_seats.include? @seat
      end

    end
  end
end