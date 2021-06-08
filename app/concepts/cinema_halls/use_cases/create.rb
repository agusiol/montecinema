module CinemaHalls
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(params:)
        seats = CinemaHalls::UseCases::GenerateSeats.new(params[:capacity].to_i).call
        params[:seats] = seats
        repository.create(params)
      end
    end
  end
end
