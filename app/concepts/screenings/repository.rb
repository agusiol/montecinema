module Screenings
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Screening)
      @adapter = adapter
    end

    def today
      @adapter.where(date: Date.today.all_day)

    end



  end
end

  