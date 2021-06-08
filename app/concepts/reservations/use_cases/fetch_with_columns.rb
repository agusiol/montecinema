# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchWithColumns
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(screening_id)
        repository.fetch_with_columns(
          columns: %i[id ticket_desk_id screening_id status client_id],
          filter: { screening_id: screening_id }
        )
      end
    end
  end
end
