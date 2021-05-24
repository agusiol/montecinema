class CinemaHall < ApplicationRecord
    has_many :screenings

    validates :name, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true }
end
