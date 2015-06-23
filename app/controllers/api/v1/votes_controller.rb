class Api::V1::VotesController < Api::V1::BaseController

    respond_to :json

  def index
    if params[:school_class_id]
      cond = "school_class_id=#{params[:school_class_id]}"
    elsif 
      cond = "teacher_id=#{params[:teacher_id]}"
    end
        
    @votes = Vote.where(cond).order('id desc')
    
    voted = []

    @votes.each do |vote|
      user_ids = []
      vote.vote_options.each do |option|
        # user_ids  += Ticket.select('user_id').where("#option.id = vote_option_id")
        user_ids  += Ticket.where("vote_option_id = #{option.id}").map {|t| t.user_id }
        # user_ids  += Ticket.where("vote_option_id = #{option.id}").values
      end
      h = {}
      h[:id] = vote.id
      user_ids.include?(params[:user_id].to_i) ? h[:is_voted] = true : h[:is_voted] = false


      voted << h
    end

    render json: {votes: @votes, voted: voted}
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
    result = @vote.vote_options.map do |o|
      [o.id, o.title, o.tickets.count]
    end
    render json: {vote: @vote, vote_option: @vote.vote_options, result: result}
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

  def close
    @vote = Vote.find(params[:id])
    @vote.state = "close"
    @vote.save!
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
