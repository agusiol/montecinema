class TicketDesk < ApplicationRecord
    has_many :reservations
    self.inheritance_column = nil
end
