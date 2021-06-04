FactoryBot.define do
  factory :movie do
    title { "Some Title"}
    genre {"example"}
    age_allowed { 16 }
    duration { 120 }

  end
end