class CreatePromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :promotions do |t|
      t.text :description
      t.string :code

      t.timestamps
    end
  end
end
