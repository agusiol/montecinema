class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :ticket_desk
  belongs_to :client
  has_many :tickets
end
