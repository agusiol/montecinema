# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    status { 'confirmed' }
    association :screening, factory: :screening
    association :client, factory: :client
    association :ticket_desk, factory: :ticket_desk
  end
end
