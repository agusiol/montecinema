# frozen_string_literal: true

FactoryBot.define do
  factory :cinema_hall do
    name { 'Some name' }
    capacity { 50 }
    seats { [] }
  end
end
