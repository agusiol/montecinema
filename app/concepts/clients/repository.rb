# frozen_string_literal: true

module Clients
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Client)
      super
    end
  end
end
