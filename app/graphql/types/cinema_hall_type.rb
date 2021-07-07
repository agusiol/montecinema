# frozen_string_literal: true

module Types
  class CinemaHallType < Types::BaseObject
    description 'CinemaHall type'
    field :id, ID, null: false
    field :name, String, null: false
    field :capacity, Integer, null: false
    field :seats, [String], null: false
    field :screenings, [Types::ScreeningType], null: true
  end
end