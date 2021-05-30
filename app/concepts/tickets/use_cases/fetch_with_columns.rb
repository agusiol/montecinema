module Tickets
  module UseCases
    class FetchWithColumns
      attr_reader :repository

      def initialize(repository: Tickets::Repository.new)
        @repository = repository
      end

      def call(reservation_id)
        repository.fetch_with_columns(
          columns: [:id, :reservation_id, :type,  :price, :seat],
          filter: {reservation_id: reservation_id}
          )
      end
    end
  end
end