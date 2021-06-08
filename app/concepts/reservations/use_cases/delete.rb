module Reservations
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.delete(id)
      end
    end
  end
end
