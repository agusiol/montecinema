class RemoveValidToFromReservation < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :valid_to, :DateTime
  end
end
