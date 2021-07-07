# frozen_string_literal: true

module Types
  class MovieType < Types::BaseObject
    description 'Movie type'
    field :id, ID, null: false
    field :title, String, null: false
    field :genre, String, null: false
    field :age_allowed, Integer, null: false
    field :duration, Integer, null: false
    field :screenings, [Types::ScreeningType], null: true
  end
end
