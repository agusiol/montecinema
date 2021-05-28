class Client < ApplicationRecord
    has_many :reservations
    has_many :clients_promotions
    has_many :promotions, through: :clients_promotions

    validates :name, :age,  presence: true
    validates :email, presence: true
end

