module CinemaHalls
  module Representers
    class Single
      attr_reader :cinema_hall

      def initialize(cinema_hall)
        @cinema_hall = cinema_hall
      end

      def call
        {
          id: cinema_hall.id,
          name: cinema_hall.name,
          capacity: cinema_hall.capacity,
          seats: cinema_hall.seats
        }
      end
    end
  end
end
