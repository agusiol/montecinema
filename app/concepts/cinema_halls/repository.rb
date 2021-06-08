module CinemaHalls
  class Repository < ::Base::BaseRepository
    def initialize(adapter: CinemaHall)
      @adapter = adapter
    end
  end
end
