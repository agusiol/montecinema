module Reservations
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Reservation)
      @adapter = adapter
    end


  end
end

  