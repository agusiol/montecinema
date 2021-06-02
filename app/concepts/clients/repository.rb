module Clients
  class Repository < ::Base::BaseRepository

    def initialize(adapter: Client)
      @adapter = adapter
    end
  end
end