# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  def update?
    user.admin?
  end
end
