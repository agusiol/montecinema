module Reservations
  module UseCases
    class FetchUnpaidReservations
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(screening_id)
        repository.fetch_with_columns(
          columns: [:id, :status, :screening_id,],
          filter: {status: "confirmed", screening_id: screening_id}
          )
      end
    end
  end
end