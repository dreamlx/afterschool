class Api::V1::InformsController < Api::V1::BaseController

  respond_to :json

  def index
    cond = "teacher_id=#{params[:teacher_id]} and school_class_id=#{params[:school_class_id]}"
    @informs = Inform.where(cond).order('id desc')
    render json: @informs
  end

  def update
    @inform = Inform.find(params[:id])
    @inform.update!(inform_params)
    render_msg 'ok'
  end

  def create
    @inform = Inform.new(inform_params)
    @inform.save!
    render_msg 'ok'
  end

  def show
    @inform = Inform.find(params[:id])
    render json: @inform
  end

  def destroy
    @inform = Inform.find(params[:id])
    @inform.destroy!
    render_msg 'ok'
  end

  private

  def inform_params
    params.require(:inform).permit!
  end

end
