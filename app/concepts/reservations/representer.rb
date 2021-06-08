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
          ticket_desk_id: reservation.ticket_desk_id,
          client_id: reservation.client_id
        }
      end
    end

    def extended
      reservations.map do |reservation|
        {
          id: reservation.id,
          status: reservation.status,
          movie_id: reservation.screening_id,
          ticket_desk_id: reservation.ticket_desk_id,
          client_id: reservation.client_id,
          tickets: Tickets::Representer.new(reservation.tickets).basic
        }
      end
    end
  end
end
