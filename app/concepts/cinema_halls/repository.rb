module CinemaHalls
  class Repository
    attr_reader :adapter

    def initialize(adapter: CinemaHall)
      @adapter = adapter
    end

    # def fetch_all(columns:)
    #   adapter.select(*columns)
    # end
    def find_all
      adapter.order(:id).all
    end

    def find_by(id)
      adapter.find(id)
    end

    def create(params)
      adapter.create(params)
    end

    def update(id, params)
      adapter.update(id, params)
    end

    def delete(id)
      adapter.destroy(id)
    end
  end
end