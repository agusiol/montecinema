class CinemaHallPolicy < ApplicationPolicy
  
  def update?
    user.employee? ||  user.admin?
  end
end