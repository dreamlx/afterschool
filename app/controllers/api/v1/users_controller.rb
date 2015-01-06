class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json

  before_action :set_user, only: [:index, :update, :destroy]

  # get
  def index
    @users = User.paginate(:page => params[:page], :per_page => 12)
    render json: { users: @users }, status: 200
  end

  def index

  end

  # put
  def create
  
  end

  # post
  def update

  end

  # delete
  def destroy

  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
