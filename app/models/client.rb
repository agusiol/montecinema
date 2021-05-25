class Client < ApplicationRecord
    has_many :clients_promotions
    has_many :promotions, :through: :clients_promotions
end
