module Reservations
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Reservation)
      @adapter = adapter
    end
    
    def unpaid(screening)
      adapter.where(status: "confirmed", screening_id: screening.id)
    end

  end
end

  