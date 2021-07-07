# frozen_string_literal: true

module Types
  class ScreeningType < Types::BaseObject
    description 'Movie type'
    field :id, ID, null: false
    field :date, ::GraphQL::Types::ISO8601DateTime, null: false
    field :available_seats, [String] , null: true
    field :cinema_hall, ::Types::CinemaHallType, null: true

  

  def available_seats

    ::Screenings::UseCases::FindAvailableSeats.new(object.id).call
  end

  end
end