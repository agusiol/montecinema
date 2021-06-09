# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateReservationWithTickets
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(params:)
        Reservation.transaction do
          reservation_params = params.except(:tickets)
          @reservation = @repository.create(reservation_params)
          Tickets::UseCases::Create.new.call(reservation: @reservation, tickets: params[:tickets])
        end
      end
    end
  end
end
