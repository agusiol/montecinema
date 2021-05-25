class AddClientRefToReservation < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :client, foreign_key: true
  end
end
