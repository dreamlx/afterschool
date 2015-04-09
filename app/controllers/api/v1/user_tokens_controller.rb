class Api::V1::UserTokensController  < Api::V1::BaseController

  respond_to :json

  def index
    render json: { message: 'get token: /api/v1/user_tokens/:id' }, status: 200
  end

  # 登陆就是验证token的过程
  def create
    user = User.find_for_database_authentication(params[:user])
    return render json: { error: 'user not allow' }, status: 401 unless user

    if user.valid_password?(params[:user][:password])
      sign_in("user", user)
      user.ensure_authentication_token

      render json: { token: user.authentication_token, user_id: user.id, user: user }
    else
      render json: { error: 'error password' }, status: 404
    end
  end

  def destroy
    @user = User.find_by(:id => params[:id])

    if @user.nil?
      logger.info("Token not found.")
      render :status => 404, :json => { :error=>"Invalid token" }
    else
      @user.reset_authentication_token!
      render json: { success: true }
    end

  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, profile_attributes: [])
  end

end