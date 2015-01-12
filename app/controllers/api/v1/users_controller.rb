class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json

  def index
    @users = User.paginate(:page => params[:page], :per_page => 12)
    render json: { users: @users }, status: 200
  end

  # 查看他人的
  def show
    @user = User.find(params[:id])
    render json: { user: @user }, status: 200  
  end

  # 创建新的用户
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
    the_params = params.require(:user).permit(:email, :password, :password_confirmation, :role, profile_attributes: [])
    return the_params
  end
  
end
