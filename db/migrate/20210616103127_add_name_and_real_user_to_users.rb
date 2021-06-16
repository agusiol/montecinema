class AddNameAndRealUserToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :real_user, :boolean, default: true
  end
end
