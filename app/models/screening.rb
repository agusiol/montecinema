class Screening < ApplicationRecord
  belongs_to :cinema_hall
  belongs_to :movie
  has_many :reservations

  validates :date, presence: true
end
