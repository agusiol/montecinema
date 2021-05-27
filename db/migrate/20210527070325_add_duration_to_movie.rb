class AddDurationToMovie < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :duration, :integer
  end
end
