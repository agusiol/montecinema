# frozen_string_literal: true

module Screenings
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Screening)
      @adapter = adapter
    end

    def today
      @adapter.where(date: Date.today.all_day)
    end

    def thirty_minutes_from_now
      @adapter.where(date: Time.now..Time.now + 30.minutes)
    end
  end
end
