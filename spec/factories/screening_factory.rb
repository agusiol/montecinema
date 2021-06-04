FactoryBot.define do
  factory :screening do
    date { "2021-07-21T15:30:00" }
    cinema_hall_id { 1 }
    movie_id { 1 }
  end
end
