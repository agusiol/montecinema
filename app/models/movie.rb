class Movie < ApplicationRecord
    has_many :screenings

    validates :title, :genre, presence: true
    validates :age_allowed, presence: true, numericality: { only_integer: true }
end
