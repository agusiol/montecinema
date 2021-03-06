# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  factory :user do
    name { 'Test User' }
    email { generate :email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
