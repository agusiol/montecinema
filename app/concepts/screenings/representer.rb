# frozen_string_literal: true

module Screenings
  class Representer
    attr_reader :screenings

    def initialize(screenings)
      @screenings = screenings
    end

    def basic
      screenings.map do |screening|
        {
          id: screening.id,
          date: screening.date,
          cinema_hall_name: screening.cinema_hall.name
        }
      end
    end

    def extended
      screenings.map do |screening|
        {
          id: screening.id,
          date: screening.date,
          movie_title: screening.movie.title,
          cinema_hall_name: screening.cinema_hall.name,
          valid_to: screening.date - 30.minutes,
          available_seats: UseCases::FindAvailableSeats.new(screening.id).call
        }
      end
    end
  end
end
