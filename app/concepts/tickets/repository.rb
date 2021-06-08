# frozen_string_literal: true

module Tickets
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Ticket)
      @adapter = adapter
    end
  end
end
