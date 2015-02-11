class Api::V1::TeachersController < Api::V1::BaseController
  
  respond_to :json

  def index
    @teachers = Teacher.paginate(:page => params[:page], :per_page => 12)
    render json: { teachers: @teachers }, status: 200
  end

  # 查看他人的
  def show
    @teacher = Teacher.find(params[:id])
    render json: { teacher: @teacher }, status: 200  
  end

  def create
    @teacher = Teacher.find_by_email(params[:email])
    if @teacher
      render json: { error: { message: "当前邮箱已经被注册" } }
    else
      @teacher = Teacher.new(teacher_params)
      if @teacher.save
        render json: { teacher: @teacher }, status: 201
      else
        render json: { error: { message: "create failed" } }, status: 400
      end
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      render json: { teacher: @teacher }, status: 201
    else
      render json: { error: { message: "update failed" } }, status: 400
    end 
  end

  def destroy

  end

  private

  def teacher_params
    the_params = params.require(:teacher).permit(:nickname, :phone, :email, :password, :password_confirmation, :role, profile_attributes: [])
    return the_params
  end
end