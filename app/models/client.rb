class Client < ApplicationRecord
    has_many :reservations
    has_many :clients_promotions
    has_many :promotions, :through: :clients_promotions
end
