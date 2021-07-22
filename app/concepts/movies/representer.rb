# frozen_string_literal: true

module Movies
  class Representer
    attr_reader :movies

    def initialize(movies)
      @movies = movies
    end

    def basic
      movies.map do |movie|
        {
          id: movie.id,
          title: movie.title,
          genre: movie.genre,
          age_allowed: movie.age_allowed,
          duration: movie.duration
        }
      end
    end

    def extended
      movies.map do |movie|
        {
          id: movie.id,
          title: movie.title,
          url: movie.image_url,
          genre: movie.genre,
          age_allowed: movie.age_allowed,
          duration: movie.duration,
          screenings: Screenings::Representer.new(next_scrrenings(movie.id)).basic
        }
      end
    end

    private

    def next_scrrenings(movie_id)
      @screenings = Screenings::Repository.new.next_five(movie_id)
    end
  end
end
