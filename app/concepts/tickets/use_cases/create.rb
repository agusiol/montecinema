# frozen_string_literal: true

module Tickets
  module UseCases
    class Create
      attr_reader :reservation, :tickets

      SeatsNotAvailableError = Class.new(StandardError)

      def initialize(repository: Tickets::Repository.new)
        @repository = repository
      end

      def call(reservation:, tickets: [])
        tickets.each do |ticket|
          raise SeatsNotAvailableError, 'Provided seats are not available!' unless SeatAvailable.new(reservation.id,
                                                                                                     ticket[:seat]).call

          @ticket = @repository.create(ticket.merge({ "reservation_id": reservation.id }))
        end
      end
    end
  end
end
