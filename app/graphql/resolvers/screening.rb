module Resolvers
  class Screening < GraphQL::Schema::Resolver
    description 'Find a screenig by ID'

    type ::Types::ScreeningType, null: false
    argument :id, ID, required: true
    

 
    def resolve(id:)
      Screenings::Repository.new.find_by(id)
      
    end
  end
end