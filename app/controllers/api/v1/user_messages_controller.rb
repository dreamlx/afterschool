class Api::V1::UserMessagesController < Api::V1::BaseController
  respond_to :json
  def index
    @user_messages = Teacher.find(params[:teacher_id]).received_messages.paginate(:page => params[:page], :per_page => 12)  unless params[:teacher_id].blank?
    @user_messages = Student.find(params[:student_id]).received_messages.paginate(:page => params[:page], :per_page => 12)  unless params[:student_id].blank?
    render json: { user_messages: @user_messages }
  end

  def user_messages
  	@user_messages = Teacher.find(params[:teacher_id]).received_messages.paginate(:page => params[:page], :per_page => 12)  unless params[:teacher_id].blank?
  	@user_messages = Student.find(params[:student_id]).received_messages.paginate(:page => params[:page], :per_page => 12)  unless params[:student_id].blank?
  	render json: { user_messages: @user_messages }
  end

  def send_message_to_person
    senduser = User.find(params[:id])
    received_user = User.find(params[:received_user_id])
    message = senduser.send_message(received_user, params[:topic], params[:body], 'user_message')
    render json: {message: message }, status: 200
  end

  def send_message_to_class
    senduser = User.find(params[:id])
    sc = SchoolClass.find(params[:school_class_id])
    message = nil
    unless sc.nil?
      sc.students.each do |received_user|
        message = senduser.send_message(received_user, params[:topic], params[:body], 'user_message')
      end
    end
    render json: {message: message }, status: 200
  end

end