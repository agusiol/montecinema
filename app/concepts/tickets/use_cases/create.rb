module Tickets
  module UseCases
    class Create
      attr_reader :reservation, :tickets
      SeatsNotAvailableError = Class.new(StandardError)

    def initialize(reservation:, tickets: []) 
      @tickets = tickets
      @reservation  = reservation
    end

    def call
      tickets.each do |ticket|
        if not SeatAvailable.new(@reservation.id, ticket[:seat]).call
          raise SeatsNotAvailableError
        end
        @reservation.tickets.create(ticket)
      end
    end


    end
  end
end

