class Api::V1::UserMessagesController < Api::V1::BaseController
  respond_to :json
  def index
  	@user_messages = Teacher.find(params[:teacher_id]).received_messages unless params[:teacher_id].blank?
  	@user_messages = Student.find(params[:student_id]).received_messages unless params[:student_id].blank?
  	render json: { user_messages: @user_messages }
  end

  def send_message
  	senduser = User.find(params[:user_id])
  	reciveuser = User.find(params[:reciveuser_id])
  	senduser.send_message(reciveuser, params[:topic], params[:body])
  	render json: {message: 'send success'}, status: 200
  end
end