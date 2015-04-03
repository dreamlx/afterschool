class Api::V1::HomeWorksController < Api::V1::BaseController
  respond_to :json

  def index
    home_works = HomeWork.limit(100)  

  	if !params[:student_id].blank? and !params[:id].blank?
      home_works = HomeWork.where( student_id: params[:student_id], work_paper_id: params[:id])    
    else
      unless params[:student_id].blank?
        home_works = Student.find(params[:student_id]).home_works 
      end
      
      unless params[:id].blank?
        home_works = WorkPaper.find(params[:id]).home_works 
      end
    end

    if params[:un_review] == 1
      home_works = home_works.un_review 
    elsif params[:un_review] == 0
      home_works = home_works.reviewed
    end



    @home_works = home_works.order(:updated_at => :desc).paginate(:page => params[:page], :per_page => 12) 
    
    
  	render json: format_homeworks(@home_works)
  end

  def show
  	@home_work = HomeWork.find(params[:id])
  	render json: format_homework(@home_work)
  end

  def create
    @home_work = Student.find(params[:student_id]).home_works.build(home_work_params)
    if @home_work

      # params[:media_avatars].each do |media_avatar|
      #   _description = media_avatar[:description] if media_avatar[:description]
      #   _avatar = parse_data(media_avatar[:avatar]) if media_avatar[:avatar]
      #   @work_paper.media_resources.build(description: _description, avatar: _avatar)
      # end

      if @home_work.save
        render json: format_homework(@home_work) , status: 201
      else
        render json: { error: { message: "创建作业失败, 请检查您的媒体文件" } }, status: 400
      end
    
    else
      render json: { error: { message: "创建作业失败, 请核实您的身份" } }, status: 400
    end

  end

  def destroy
  	hw = HomeWork.find(params[:id])
  	if hw
  		hw.destroy
  		render json: { message: 'deleted'}
  	else
  		render json: { message: 'no found'}, status: 404
  	end
  end

  private
  def home_work_params
    params.require(:home_work).permit(:title, :description, :paper_type, :media_avatars, :work_paper_id, :student_id)
  end

end