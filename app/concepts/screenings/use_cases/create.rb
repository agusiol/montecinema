module Screenings
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: Screenings::Repository.new)
        @repository = repository
      end

      def call(params:)
        cinema_hall = CinemaHalls::Repository.new.find_by(params[:cinema_hall_id])
        params[:available_seats] = cinema_hall.seats
        repository.create(params)
      end
    end
  end
end
