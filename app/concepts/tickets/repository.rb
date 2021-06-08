# frozen_string_literal: true

module Tickets
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Ticket)
      super
    end
  end
end
