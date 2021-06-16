# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json
  include ActionController::MimeResponds
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :real_user])
  end

  def staff_authenticate
    authorize :staff, :staff?
  end

  def admin_authenticate
    authorize :staff, :admin?
  end

  private

  def user_not_authorized
    render json: { message: 'You are not allowed to access!' }
  end
end
