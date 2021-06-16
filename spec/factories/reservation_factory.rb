# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    status { 'confirmed' }
    association :screening, factory: :screening
    association :user, factory: :user
  end
end
