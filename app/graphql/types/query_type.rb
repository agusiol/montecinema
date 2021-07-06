# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :movie, MovieType, null: true do
      description 'Find a movie by ID'
      argument :id, ID, required: true
    end

    # Then provide an implementation:
    def movie(id:)
      Movies::Repository.new.find_by(id)
    end
  end
end
