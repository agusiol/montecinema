# frozen_string_literal: true

class ClientsPromotion < ApplicationRecord
  belongs_to :client
  belongs_to :promotion
end
