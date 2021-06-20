# frozen_string_literal: true

StaffPolicy = Struct.new(:user, :staff) do
  def staff?
    user.employee? || user.admin?
  end

  def admin?
    user.admin?
  end
end
