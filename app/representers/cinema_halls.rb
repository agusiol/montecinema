
module Representers
    class CinemaHalls
        attr_reader :cinema_halls

        def initialize(cinema_halls)
            @cinema_halls = cinema_halls
        end

        def basic
            cinema_halls.map do |cinema_hall|
                {
                    id: cinema_hall.id,
                    name: cinema_hall.name,
                    seats: cinema_hall.capacity
                }
            end
        end

        def extended
            cinema_halls.map do |cinema_hall|
            end
        end
    end
end