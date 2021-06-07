module Reservations
  module UseCases
    class CreateOffline  < Reservations::UseCases::CreateReservationWithTickets
      
      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end
      
      def call(params:)
        super
      end
      


    end
  end
end