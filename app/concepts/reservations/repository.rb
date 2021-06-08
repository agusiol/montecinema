module Reservations
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Reservation)
      @adapter = adapter
    end

    def unpaid(screening_id)
      adapter.where(status: 'confirmed', screening_id: screening_id)
    end
  end
end
