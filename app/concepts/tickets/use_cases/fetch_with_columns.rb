# frozen_string_literal: true

module Tickets
  module UseCases
    class FetchWithColumns
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        @repository = repository
      end

      def call(reservation_id)
        repository.fetch_with_columns(
          columns: %i[id reservation_id ticket_type price seat],
          filter: { reservation_id: reservation_id }
        )
      end
    end
  end
end
