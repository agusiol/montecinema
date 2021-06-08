# frozen_string_literal: true

class AddTicketDeskRefToReservation < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :ticket_desk, foreign_key: true
  end
end
