class TicketDesk < ApplicationRecord
    has_many :reservations
    self.inheritance_column = _type_disabled
end
