class Screening < ApplicationRecord
  belongs_to :cinema_hall
  has_many :reservation
end
