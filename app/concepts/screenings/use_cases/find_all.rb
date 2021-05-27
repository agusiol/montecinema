
module Screenings
  module UseCases
    class FindAll
      attr_reader :repository

      def initialize(repository: Screenings::Repository.new)
        @repository = repository
      end

      def call
        repository.find_all
      end
    end
  end
end