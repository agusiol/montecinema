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
            date: ticket.price,
            movie_id: ticket.type,
            cinema_hall_id: ticket.reservation_id
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