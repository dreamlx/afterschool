class Api::V1::StudentsController < Api::V1::BaseController

  respond_to :json

  def homeworks
    # 查看自己的作业
  end

  def index 
    @students = Student.paginate(:page => params[:page], :per_page => 12)
    render json: { students: @students }, status: 200
  end

  def show
    @student = Student.find(params[:id])
    render json: { student: @student }, status: 200
  end

  def create
    @student = Student.find_by_email(params[:email])
    if @student
      render json: { error: { message: "当前邮箱已经被注册" } }
    else
      @student = Student.new(student_params)
      if @student.save
        render json: { student: @student }, status: 201
      else
        render json: { error: { message: "create failed" } }, status: 400
      end
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      render json: { student: @student }, status: 201
    else
      render json: { error: { message: "update failed" } }, status: 400
    end
  end

  def destroy

  end

  private

  def student_params
    the_params = params.require(:teacher).permit(:email, :password, :password_confirmation, :role, profile_attributes: [])
    return the_params
  end
end