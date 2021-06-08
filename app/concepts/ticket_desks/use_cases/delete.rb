# frozen_string_literal: true

module TicketDesks
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: TicketDesks::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.delete(id)
      end
    end
  end
end
