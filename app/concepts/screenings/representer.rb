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
            movie_id: screening.movie_id,
            cinema_hall_id: screening.cinema_hall_id
        }
      end
    end

    def extended
      screenings.map do |screening|
        {
          id: screening.id,
          date: screening.date,
          movie_id: screening.movie_id,
          cinema_hall_id: screening.cinema_hall_id,
          available_seats:  UseCases::FindAvailableSeats.new(screening.id).call
      }
      end
    end
  end
end