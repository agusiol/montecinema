module Screenings
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Screening)
      @adapter = adapter
    end


  end
end

  