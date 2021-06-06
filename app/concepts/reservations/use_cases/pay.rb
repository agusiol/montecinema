module Reservations
  module UseCases
    class Pay
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.update(id, :status => "paid")
      end
    end
  end
end