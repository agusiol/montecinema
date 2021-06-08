module Clients
  module UseCases
    class FindAll
      attr_reader :repository

      def initialize(repository: Clients::Repository.new)
        @repository = repository
      end

      def call
        repository.find_all
      end
    end
  end
end
