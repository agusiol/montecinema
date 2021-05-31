module Reservations
  module UseCases
    class Create
<<<<<<< HEAD
      attr_reader :repository, :params
=======
      attr_reader :repository
>>>>>>> f6136dcd4ca59c4afe052944e81feffbc7e4245b

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(params:)
        repository.create(params)
      end
    end
  end
end