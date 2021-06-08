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
      end
    end
  end
end
