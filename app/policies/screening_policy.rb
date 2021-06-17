class ScreeningPolicy < ApplicationPolicy
  def show?
    user.admin? || user.employee?
  end

  def update?
    user.employee? || user.admin?
  end

  def new?
    create?
  end

  def create?
    user.admin? || user.employee?
  end

  def destroy?
    user.admin? || user.employee?
  end
end
