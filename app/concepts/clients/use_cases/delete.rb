# frozen_string_literal: true

module Clients
  module UseCases
    class Delete
      attr_reader :repository

      def initialize(repository: Clients::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.delete(id)
      end
    end
  end
end
