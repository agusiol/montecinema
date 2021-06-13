# frozen_string_literal: true

module Screenings
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: Screenings::Repository.new)
        @repository = repository
      end

      def call(params:)
        screening = repository.create(params)
        byebug
        CancelReservationsJob.set(wait_until: screening.date - 30.minutes).perform_later(screening.id)
        screening
      end
    end
  end
end
