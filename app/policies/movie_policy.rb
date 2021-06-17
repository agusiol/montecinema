class MoviePolicy < ApplicationPolicy
  def show?
    user.admin? || user.employee?
  end

  def update?
    user.employee? || user.admin?
  end

  def new?
    update?
  end

  def destroy?
    user.admin? || user.employee?
  end
end
