# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  def update?
    user.employee? || user.admin?
  end
end
