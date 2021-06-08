class RemoveAvailableSeatsFromScreenings < ActiveRecord::Migration[6.1]
  def change
    remove_column :screenings, :available_seats, :array
  end
end
