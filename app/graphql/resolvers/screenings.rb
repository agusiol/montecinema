module Resolvers
  class Screenings < GraphQL::Schema::Resolver
    description 'Show all movies'

    type [::Types::ScreeningType], null: false
 
    def resolve
      ::Screenings::Repository.new.find_all
    end
  end
end