class Api::V1::TeachersController < Api::V1::UserMessagesController
  
  respond_to :json

  def index
    cid = params[:school_class_id]
    if cid
      teachers = SchoolClass.find(cid).teachers
    else
      teachers = Teacher
    end
    @teachers = paged(teachers)
    render json: { 
      teachers: @teachers, 
      current_page: @teachers.current_page,
      per_page: @teachers.per_page,
      total_entries: @teachers.total_entries
       }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: { message: 'No found' } }
  end

  # 查看他人的
  def show
    @teacher = Teacher.find(params[:id])
    if @teacher
      if @teacher.profile.nil?
        @teacher.build_profile
        @teacher.save
      end

      render json: { 
        teacher: @teacher, 
        profile: @teacher.profile, 
        school_classes: @teacher.school_classes
      } 
    else
      render json: { error: { message: 'No found' } }, status: 400
    end 
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
    params.require(:teacher).permit(:nickname, :phone, :email, :password, :password_confirmation, :role, profile_attributes: [])
  end
end