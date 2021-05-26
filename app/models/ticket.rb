class Ticket < ApplicationRecord
  belongs_to :reservation
  self.inheritance_column = :nil

end
