module Resolvers
  class Movies < GraphQL::Schema::Resolver
    description 'Show all movies'

    type [::Types::MovieType], null: false
 
    def resolve
      ::Movies::Repository.new.find_all
    end
  end
end