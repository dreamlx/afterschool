class Api::V1::TeachersController < Api::V1::BaseController
  
  respond_to :json

  def index
    teachers = SchoolClass.find(params[:school_class_id]).teachers unless params[:school_class_id].blank?
    if teachers.nil?
      @teachers = Teacher.paginate(:page => params[:page], :per_page => 12) 
    else
      @teachers = teachers.paginate(:page => params[:page], :per_page => 12)
    end    
  
    render json: { 
      :students => @teachers, 
      :current_page => @teachers.current_page,
      :per_page => @teachers.per_page,
      :total_entries => @teachers.total_entries
       }, status: 200
  end

  # 查看他人的
  def show
    @teacher = Teacher.find(params[:id])
    if @teacher
      render json: { 
        student: @teacher, 
        profile: @teacher.profile, 
        school_classes: @teacher.school_classes
      }, status: 200 
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


  def send_message_to_person
    senduser = User.find(params[:teacher_id])
    received_user = User.find(params[:received_user_id])
    message = senduser.send_message(received_user, params[:topic], params[:body], 'user_message')
    render json: {message: message }, status: 200
  end

  def send_message_to_class
    senduser = User.find(params[:teacher_id])
    sc = SchoolClass.find(params[:school_class_id])
    unless sc.nil?
      sc.students.each do |received_user|
        message = senduser.send_message(received_user, params[:topic], params[:body], 'user_message')
      end
    end
    render json: {message: message }, status: 200
  end


  private

  def teacher_params
    the_params = params.require(:teacher).permit(:nickname, :phone, :email, :password, :password_confirmation, :role, profile_attributes: [])
    return the_params
  end
end