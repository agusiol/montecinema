# frozen_string_literal: true

module Screenings
  module UseCases
    class FetchWithColumns
      attr_reader :repository

      def initialize(repository: Screenings::Repository.new)
        @repository = repository
      end

      def call(cinema_hall_id, movie_id)
        repository.fetch_with_columns(
          columns: %i[id movie_id cinema_hall_id date],
          filter: { cinema_hall_id: cinema_hall_id, movie_id: movie_id }
        )
      end
    end
  end
end
