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
            title: screening.date,
            genre: screening.movie_id,
        }
      end
    end

    def extended
      screenings.map do |screening|
        screening

      end
    end
  end
end