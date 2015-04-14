class Api::V1::HomeWorksController < Api::V1::BaseController

  respond_to :json

  def index
    #home_works = HomeWork.limit(100)  

  	if !params[:student_id].blank? and !params[:work_paper_id].blank?
      home_works = HomeWork.where( student_id: params[:student_id], work_paper_id: params[:work_paper_id])    
    else
      unless params[:student_id].blank?
        home_works = Student.find(params[:student_id]).home_works 
      end
      
      unless params[:work_paper_id].blank?
        home_works = WorkPaper.find(params[:work_paper_id]).home_works 
      end
    end

    if params[:review_status] == 'un_review'
      home_works = home_works.un_review 
    elsif params[:review_status] == 'reviewed'
      home_works = home_works.reviewed
    end

    @home_works = paged home_works.order(:updated_at => :desc)
  	render json: format_homeworks(@home_works)
  end

  def show
  	@home_work = HomeWork.find(params[:id])
  	render json: format_homework(@home_work)
  end

  def un_review

    home_works = Teacher.find(params[:teacher_id]).home_works.un_review           unless params[:teacher_id].nil?
    home_works = Student.find(params[:student_id]).home_works.un_review           unless params[:student_id].nil?
    home_works = SchoolClass.find(params[:school_class_id]).home_works.un_review  unless params[:school_class_id].nil?
    home_works = WorkPaper.find(params[:work_paper_id]).home_works.un_review      unless params[:work_paper_id].nil?
    
    home_works = HomeWork.un_review if home_works.nil?

    if !params[:teacher_id].nil? and !params[:school_class_id].nil?
      home_works = []
      Teacher.find(params[:teacher_id]).home_works.un_review.order(:updated_at => :desc).each do |item|
        home_works << item if item.student.school_class.id == params[:school_class_id]
      end
    end

    home_works = home_works.order(:updated_at => :desc) 
    @home_works = home_works.blank? ? [] : paged(home_works)
    render json: format_homeworks(@home_works)
  end

  def create
    @home_work = Student.find(params[:student_id]).home_works.build(home_work_params)
    if @home_work
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
    params.require(:home_work).permit(:title, :description, :paper_type, 
      :media_avatars, :work_paper_id, :student_id)
  end

end

      ## def create
      #
      # params[:media_avatars].each do |media_avatar|
      #   _description = media_avatar[:description] if media_avatar[:description]
      #   _avatar = parse_data(media_avatar[:avatar]) if media_avatar[:avatar]
      #   @work_paper.media_resources.build(description: _description, avatar: _avatar)
      # end
