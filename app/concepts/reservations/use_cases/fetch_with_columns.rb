module Reservations
  module UseCases
    class FetchWithColumns
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(screening_id, ticket_desk_id)
        repository.fetch_with_columns(
          columns: [:id, :ticket_desk_id, :screening_id, :status],
          filter: {screening_id: screening_id, ticket_desk_id: ticket_desk_id,}
          )
      end
    end
  end
end