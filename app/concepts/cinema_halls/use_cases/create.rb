module CinemaHalls
  module UseCases
    class Create
      attr_reader :repository, :params

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(params:)
        repository.create(params)
        repository.seats = CinemaHalls::UseCases::GenerateSeats.new.(repository.capacity).call
        repository.save!
      end
    end
  end
end