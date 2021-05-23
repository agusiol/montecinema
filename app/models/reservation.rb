class Reservation < ApplicationRecord
  belongs_to :screening
  has_many :tickets
end
