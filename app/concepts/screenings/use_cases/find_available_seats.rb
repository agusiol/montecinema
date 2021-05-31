module Screenings
  module UseCases
    class FindAvailableSeats 

      def initialize(screening_id)
        @reservations = Reservations::UseCases::FetchReservationsForScreening.new.call(screening_id)
        screening = Screenings::Repository.new.find_by(screening_id)
        cinema_hall = CinemaHalls::Repository.new.find_by(screening.cinema_hall_id)
        @seats = cinema_hall.seats
      end

      def call
        find_reserved_seats
        find_available_seats
        @available_seats
        
      end

      def find_reserved_seats
        @taken_seats =Array.new
        @reservations.includes(:tickets).map do |reservation|
          reservation.tickets.map do |ticket|
            @taken_seats.push(ticket.seat)
          end
        end
        @taken_seats
      end

      def find_available_seats
        @available_seats = @seats - @taken_seats
      end
    end
  end
end