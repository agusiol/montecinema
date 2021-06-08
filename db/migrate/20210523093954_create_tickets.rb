# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :seat
      t.string :type
      t.float :price
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
