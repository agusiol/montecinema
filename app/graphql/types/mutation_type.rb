# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_movie, mutation: ::Mutations::CreateMovie
  end
end
