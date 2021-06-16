class StaffPolicy < Struct.new(:user, :staff)
  def staff?
    user.employee? || user.admin?
  end

  def admin?
    user.admin?
  end
end