# frozen_string_literal: true

class TicketDesk < ApplicationRecord
  has_many :reservations
end
