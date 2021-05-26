module Repositories
    class CinemaHallRepository
        attr_reader :adapter

        def initialize(adapter: CinemaHall)
            @adapter = adapter
        end

        def fetch_all_with_columns(columns:)
            adapter.select(*columns)
        end

        # def find_all
        #     adapter.all
        #end
    end
end