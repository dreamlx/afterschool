class Api::V1::UserMessagesController < Api::V1::BaseController

  respond_to :json

  def index
  end

  def user_messages
    msg_type = params[:message_type]
    if  msg_type and msg_type.upcase == 'NOTOP'
      user_messages = User.find(params[:id])
                            .received_messages
                            .where("message_type<>'TOP'")
    elsif msg_type
      user_messages = User.find(params[:id])
                            .received_messages
                            .where("message_type='#{msg_type}'")
    else
      user_messages = User.find(params[:id])
                            .received_messages
    end
    @user_messages = paged user_messages

    render json: { user_messages: @user_messages }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def send_message_to_person
    senduser = User.find(params[:id])
    received_user = User.find(params[:received_user_id])
    msg_type = params[:message_type] || 'user_message'
    message = senduser.send_message(received_user, params[:topic], params[:body], msg_type)
    render json: { message: message }
  end

  def send_message_to_class
    senduser = User.find(params[:id])
    sc = SchoolClass.find(params[:school_class_id])
    message = nil
    unless sc.nil?
      msg_type = params[:message_type] || 'user_message'
      sc.students.each do |received_user|
        message = senduser.send_message(received_user, params[:topic], params[:body], msg_type)
      end
    end
    render json: { message: message }
  end

  def show
    message = UserMessage.find(params[:id])
    render json: { message: message }
  rescue
    render json: { error: { message: 'not found'} }, status: 404
  end

end
