module UseCases
    module CinemaHalls
        class FetchForCinemaHalls
            attr_reader :repository

            def initialize(repository: Repositories::CinemaHallRepository.new)
                @repository = repository
            end

            def call
                repository.fetch_all_with_columns(
                    columns: [:id, :name, :capacity]
                )
            end
        end
    end
end