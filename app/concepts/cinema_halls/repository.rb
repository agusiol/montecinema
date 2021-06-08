# frozen_string_literal: true

module CinemaHalls
  class Repository < ::Base::BaseRepository
    def initialize(adapter: CinemaHall)
      super
    end
  end
end
