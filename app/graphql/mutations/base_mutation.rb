# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject

    def check_authentication!
      return if context[:current_user]
      raise GraphQL::ExecutionError.new("Not authenticated", extensions: {code: "UNAUTHORIZED"})
    end

    def staff_authorize!
      return if context[:current_user].admin? || context[:current_user].employee?
      raise GraphQL::ExecutionError.new("Not a staff member", extensions: {code: "UNAUTHORIZED"})
    end
  end
end
