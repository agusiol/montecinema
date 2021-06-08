# frozen_string_literal: true

class CreateCinemaHalls < ActiveRecord::Migration[6.1]
  def change
    create_table :cinema_halls do |t|
      t.string :name
      t.integer :capacity

      t.timestamps
    end
  end
end
