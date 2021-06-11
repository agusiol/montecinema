# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { 'Some name' }
    age { 16 }
    email { 'example@email.com' }
    real_user { true }
  end
end
