# frozen_string_literal: true

class AddMovieRefToScreenings < ActiveRecord::Migration[6.1]
  def change
    add_reference :screenings, :movie, foreign_key: true
  end
end
