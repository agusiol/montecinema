FactoryBot.define do
  factory :reservation do
    status {"confirmed"}
    association :screening
    association :client
    association :ticket_desk
    
  end
end