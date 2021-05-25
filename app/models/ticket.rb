class Ticket < ApplicationRecord
  belongs_to :reservation
  self.inheritance_column = :_type_disabled

end
