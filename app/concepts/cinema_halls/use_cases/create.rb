module CinemaHalls
  module UseCases
    class Create
      attr_reader :repository, :params

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(params:)
        repository.create(params)
        seats =  CinemaHalls::UseCases::GenerateSeats.new(params[:capacity]).call
        #add seats
      end
    end
  end
end