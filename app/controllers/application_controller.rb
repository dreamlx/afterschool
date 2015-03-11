class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.role?(:teacher) or current_user.role?(:administrator)
      flash[:alert] = 'you are not authorized to access backend'
      redirect_to root_path
    end

  end

  def authenticate_user_from_token!
    token = params[:token].presence
    user = token && User.find_by_authentication_token(token.to_s)

    if user
      sign_in user
    end
  end
end
