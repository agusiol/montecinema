module Clients
  module UseCases
    class FindBy
      attr_reader :repository

      def initialize(repository: Clients::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.find_by(id)
      end
    end
  end
end