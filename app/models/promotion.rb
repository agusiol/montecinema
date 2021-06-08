# frozen_string_literal: true

class Promotion < ApplicationRecord
  has_many :clients_promotions
  has_many :clients, through: :clients_promotions
end
