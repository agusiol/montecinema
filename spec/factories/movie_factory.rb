# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { 'Some Title' }
    genre { 'example' }
    age_allowed { 16 }
    duration { 120 }
    image { File.open("spec/fixtures/files/test_poster.jpeg", "rb") }
  end
end
