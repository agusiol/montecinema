module Reservations
  class Representer
    attr_reader :reservations

    def initialize(reservations)
      @reservations = reservations
    end

    def basic
      reservations.map do |reservation|
        {
            id: reservation.id,
            status: reservation.status,
            movie_id: reservation.screening_id,
            cinema_hall_id: reservation.ticket_desk_id
        }
      end
    end

    def extended
      reservations
    end
  end
end
