module CinemaHalls
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.delete(id)
      end
    end
  end
end
