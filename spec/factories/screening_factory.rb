FactoryBot.define do
  factory :screening do
    date { '2021-07-21T15:30:00' }
    association :cinema_hall
    association :movie
  end
end
