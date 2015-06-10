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

  private

  def vote_params
    params.require(:vote).permit!
  end


end