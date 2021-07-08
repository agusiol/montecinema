# frozen_string_literal: true

class CinemaHall < ApplicationRecord
  has_many :screenings
end
