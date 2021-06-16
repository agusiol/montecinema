class CinemaHallPolicy < ApplicationPolicy
  def update?
    user.admin? 
  end
end