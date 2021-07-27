# frozen_string_literal: true

module Movies
  class Repository < ::Base::BaseRepository
    def initialize(adapter: Movie)
      super
    end

    def search_by_title(title)
      @adapter.where("title ILIKE ?", "%#{title}%")
    end

  end
end
