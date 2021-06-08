# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class GenerateSeats
      def initialize(capacity)
        @cinema_hall_capacity = capacity
        @seats = []
      end

      def call
        (1..@cinema_hall_capacity / 10).each { |i| ('A'..'J').each { |letter| @seats.push("#{i}#{letter}") } }
        @seats
      end
    end
  end
end
