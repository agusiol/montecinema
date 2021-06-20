# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    ticket_type { 'normal' }
    price { 15 }
    sequence(:seat) { |n| "#{n}A" }
    association :reservation, factory: :reservation
  end
end
