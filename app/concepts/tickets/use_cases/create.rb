module Tickets
  module UseCases
    class Create
      attr_reader :repository, :params

      def initialize(repository: Tickets::Repository.new)
        @repository = repository
      end

      def call(params:)
          repository.create(params)
      end
    end
  end
end