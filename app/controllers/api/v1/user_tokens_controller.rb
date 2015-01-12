class Api::V1::UserTokensController  < Api::V1::BaseController
  respond_to :json

  def index

  end

  # 登陆就是验证token的过程
  def create
    user = User.find_for_database_authentication(:email => params[:user][:email])
    return render json: { error: { status: -1 } } unless user

    if user.valid_password?(params[:user][:password])
      sign_in("user", user)
      user.ensure_authentication_token

      render json: { token: user.authentication_token, user_id: user.id }
    else
      render json: { error: { status: -1 } }
    end
  end

  def destroy
    current_user.authentication_token = Devise.friendly_token
    sign_out(current_user)
    render json: { success: true }
  end
end