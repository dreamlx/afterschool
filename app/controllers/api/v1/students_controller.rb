class Api::V1::StudentsController < Api::V1::BaseController

  respond_to :json

  def homeworks
    # 查看自己的作业
  end

  def index 
    students = SchoolClass.find(params[:school_class_id]).students unless params[:school_class_id].blank?
    if students.nil?
      @students = Student.paginate(:page => params[:page], :per_page => 100) 
    else
      @students = students.paginate(:page => params[:page], :per_page => 100)
    end    
  
    render json: { 
      :students => @students, 
      :current_page => @students.current_page,
      :per_page => @students.per_page,
      :total_entries => @students.total_entries
      }, status: 200
  end

  def show
    @student = Student.find(params[:id])
    if @student
      render json: { 
        student: @student, 
        profile: @student.profile, 
        school_class: @student.school_class
      }, status: 200 
    else
      render json: { error: { message: 'No found' } }, status: 400
    end 
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
        render json: { error: @student.errors }, status: 400
      end
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      render json: { student: @student }, status: 201
    else
      render json: { error: @student.errors }, status: 400
    end
  end

  def destroy

  end

  private

  def student_params
    the_params = params.require(:student).permit(:nickname, :email, :password, :password_confirmation, profile_attributes: [])
    return the_params
  end
end