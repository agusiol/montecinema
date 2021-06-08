# frozen_string_literal: true

module TicketDesks
  class Repository < ::Base::BaseRepository
    def initialize(adapter: TicketDesk)
      @adapter = adapter
    end
  end
end
