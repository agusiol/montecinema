class AddImageDataToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :image_data, :text
  end
end
