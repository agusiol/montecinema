class ClientsPromotion < ApplicationRecord
    belongs_to :client
    belongs_to :promotion
end
