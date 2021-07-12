module Mutations
  class CreateMovie < BaseMutation
    argument :title, String, required: true
    argument :genre, String, required: true
    argument :age_allowed, Integer, required: true
    argument :duration, Integer, required: true

    field :movie, Types::MovieType, null: true
    field :errors, [String], null: false

    def resolve(**attributes)
      check_authentication!
      staff_authorize!
      
      movie = Movies::UseCases::Create.new.call(params: attributes)
      
      if movie.valid?
        {
          movie: movie,
          errors: [],
        }
      else
        {
          movie: nil,
          errors: comment.errors.full_messages
        }
      end
      # {status: 200, movie: movie}
    end
  end
end