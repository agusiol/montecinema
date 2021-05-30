module Tickets
  class Representer
    attr_reader :tickets

    def initialize(tickets)
      @tickets = tickets
    end

    def basic
      tickets.map do |ticket|
        {
            id: ticket.id,
            date: ticket.date,
            movie_id: ticket.screening_id,
            cinema_hall_id: ticket.ticket_desk_id
        }
      end
    end

    def extended
      tickets.map do |ticket|
        ticket

      end
    end
  end
end