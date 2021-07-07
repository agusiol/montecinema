module Resolvers
  class Movie < GraphQL::Schema::Resolver
    description 'Find a movie by ID'

    type ::Types::MovieType, null: false
    argument :id, ID, required: true
    

 
    def resolve(id:)
      Movies::Repository.new.find_by(id)
    end
  end
end