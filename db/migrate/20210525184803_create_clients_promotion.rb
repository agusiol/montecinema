class CreateClientsPromotion < ActiveRecord::Migration[6.1]
  def change
    create_table :clients_promotion do |t|
      t.belongs_to :client
      t.belongs_to :promotion
      t.datetime :expiry_date
      t.timestamps
    end
  end
end
