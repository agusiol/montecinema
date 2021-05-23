class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :status
      t.datetime :valid_to
      t.references :screening, null: false, foreign_key: true

      t.timestamps
    end
  end
end
