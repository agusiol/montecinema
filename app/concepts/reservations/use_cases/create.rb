module Reservations
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(params:)
        reservation = repository.create(params)
        client = Clients::UseCases::FindBy.new.call(id: params[:client_id])

        ReservationMailer.with(reservation: reservation, email: client.email).confirmation_email.deliver_now

      end
    end
  end
end