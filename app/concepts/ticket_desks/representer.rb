# frozen_string_literal: true

module TicketDesks
  class Representer
    attr_reader :ticket_desks

    def initialize(ticket_desks)
      @ticket_desks = ticket_desks
    end

    def basic
      ticket_desks.map do |ticket_desk|
        {
          id: ticket_desk.id,
          type: ticket_desk.type

        }
      end
    end

    def extended
      ticket_desks.map do |ticket_desk|
        ticket_desk
      end
    end
  end
end
