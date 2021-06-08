# frozen_string_literal: true

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
          screening_date: reservation.screening.date,
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
          screening_date: reservation.screening.date,
          movie_title: reservation.screening.movie.title,
          cinema_hall_name: reservation.screening.cinema_hall.name,
          ticket_desk_id: reservation.ticket_desk_id,
          client_id: reservation.client_id,
          tickets: Tickets::Representer.new(reservation.tickets).basic
        }
      end
    end
  end
end
