class AddSeatsToScreening < ActiveRecord::Migration[6.1]
  def change
    add_column :screenings, :seats, :text, array: true, default: []
  end
end
