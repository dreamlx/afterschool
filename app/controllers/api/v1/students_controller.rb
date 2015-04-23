class Api::V1::StudentsController < Api::V1::UserMessagesController

  respond_to :json

  def homeworks
    # 查看自己的作业
  end

  def index 
    if cid = params[:school_class_id]
      students = SchoolClass.find(cid).students
    else
      students = Student
    end
    @students = paged(students)
    render json: { 
      students: @students, 
      current_page: @students.current_page,
      per_page: @students.per_page,
      total_entries: @students.total_entries
      }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: { message: 'No found' } }
  end

  def show
    @student = Student.find(params[:id])
    if @student.profile.nil?
      @student.build_profile
      @student.save
    end
    render json: { 
      student: @student, 
      profile: @student.profile, 
      school_class: @student.school_class
    }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: { message: 'No found' } }
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
    params.require(:student).permit(:nickname, :email, :password, :password_confirmation,
     :school_class_id, profile_attributes: [])
  end
end