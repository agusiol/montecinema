# frozen_string_literal: true

module Clients
  class Repository < ::Base::BaseRepository
    attr_reader :adapter

    def initialize(adapter: Client)
      super
    end

    def offline_client
      adapter.where(real_user: false).first
    end
  end
end
