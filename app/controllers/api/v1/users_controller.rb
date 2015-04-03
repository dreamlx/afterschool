class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json

  def index
    @users = paged User
    render json: { users: @users }, status: 200
  end

  def show
    @user = User.find(params[:id])
    render json: { user: @user, profile: @user.profile, class_no: @user.class_noes }, status: 200  
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      render json: { error: { message: "当前邮箱已经被注册" } }
    else
      @user = User.new(user_params)
      if @user.save
        render json: { user: @user }, status: 201
      else
        render json: { error: { message: "create failed" } }, status: 400
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { user: @user }, status: 201
    else
      render json: { error: { message: "update failed" } }, status: 400
    end 
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, profile_attributes: [])
  end
  
end
