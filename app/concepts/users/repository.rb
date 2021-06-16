# frozen_string_literal: true

module Users
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: User)
      super
    end

    def offline_user
      adapter.where(real_user: false).first
    end
  end
end
