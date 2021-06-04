FactoryBot.define do
  factory :reservation do
    screening_id { 1 }
    client_id { 1 }
    ticket_desk_id { 1 }
    status {"confirmed"}
  end
end