class Api::V1::VotesController < Api::V1::BaseController

    respond_to :json

  def index
    cond = "teacher_id=#{params[:teacher_id]} and school_class_id=#{params[:school_class_id]}"
    @votes = Vote.where(cond).order('id desc')
    render json: @votes
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.update!(vote_params)
    render_msg 'ok'
  end

  def create
    @vote = Vote.new(vote_params)
    options = params[:vote_option][:title]
    # raise options.size.to_s
    options.each do |o|
      @vote.vote_options.build(title: o)
    end

    @vote.save!
    render_msg 'ok'
  end

  def show
    @vote = Vote.find(params[:id])
    render json: @vote
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy!
    render_msg 'ok'
  end

  def choose
    options_array = params[:ticket][:vote_option_id]
    uid = params[:ticket][:user_id]
    options_array.each do |o|
      t = Ticket.new(vote_option_id: o, user_id: uid)
      t.save!
    end
    render_msg 'ok'
  end

  private

  def ticket_params
    params.require(:ticket).permit!
  end

  def vote_params
    params.require(:vote).permit!
  end

end
