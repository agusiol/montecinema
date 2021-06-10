# frozen_string_literal: true

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
          price: ticket.price,
          ticket_type: ticket.ticket_type,
          seat: ticket.seat,
          reservation_id: ticket.reservation_id
        }
      end
    end

    def extended
      tickets
    end
  end
end
