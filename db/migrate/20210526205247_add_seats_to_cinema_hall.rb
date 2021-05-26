class AddSeatsToCinemaHall < ActiveRecord::Migration[6.1]
  def change
    add_column :cinema_halls, :seats, :text, array: true, default: []
  end
end
