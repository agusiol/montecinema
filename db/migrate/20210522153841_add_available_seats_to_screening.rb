class AddAvailableSeatsToScreening < ActiveRecord::Migration[6.1]
  def change
    add_column :screenings, :available_seats, :text, array: true, default: []
  end
end
