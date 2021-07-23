# frozen_string_literal: true

class Movie < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_many :screenings

  validates :title, :genre, presence: true
  validates :age_allowed, presence: true, numericality: { only_integer: true }
end
