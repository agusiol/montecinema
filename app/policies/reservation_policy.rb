class ReservationPolicy < ApplicationPolicy
  
  def index?
    true
  end

  def show?
    record.user_id == user.id || user.admin? || user.employee?
  end

  def update?
    user.employee? || user.admin?
  end

  def destroy?
    user.employee? || user.admin?
  end

  def create_offline?
    user.employee? || user.admin?
  end



  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.all if user.admin? || user.employee?

      scope.where(user_id: user.id)

    end
  end

end
