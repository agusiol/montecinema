# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    ticket_type { 'normal' }
    price { 15 }
    seat { '1A' }
    association :reservation, factory: :reservation
  end
end
