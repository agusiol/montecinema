# frozen_string_literal: true

module Reservations
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Reservation)
      super
      @adapter = adapter
    end

    def unpaid(screening_id)
      adapter.where(status: 'confirmed', screening_id: screening_id)
    end
  end
end
