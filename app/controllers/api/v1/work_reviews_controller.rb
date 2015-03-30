class Api::V1::WorkReviewsController < Api::V1::BaseController
  respond_to :json

  def index
  	teacher_id = params[:teacher_id]
  	work_reviews = Teacher.find(teacher_id).work_reviews unless teacher_id.nil?
  	
    if work_reviews.nil?
      @work_reviews = WorkReview.paginate(:page => params[:page], :per_page => 12)
    else
      @work_reviews = work_reviews.paginate(:page => params[:page], :per_page => 12)
    end
  
  	render json: {work_reviews: @work_reviews}	
  end

  def show
  	@work_review = WorkReview.find(params[:id]) unless params[:id].blank?
  	@work_review = HomeWork.find(params[:home_work_id]).work_review

  	render json: {work_review: @work_review}
  end

  def create
    begin
      work = HomeWork.find(params[:home_work_id])
    	@work_review = work.build_work_review(work_review_params)
    	if @work_review.save!
        work.state = 'complete'
        work.save!
    		render json: {work_review: @work_review}
    	else
    		render json: {message: @work_review.errors}, status: 400, message: '更新失败，请联系管理员'
    	end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: { message: 'No found' } }, status: 400
    end


  end

  def destroy
  	@work_review = HomeWork.find(params[:home_work_id]).work_review
  	@work_review.destroy!
  	render json:{message: 'deleted'}, status:200
  end

 private
  # 创建照片的同时也要创建资源
  # 资源都放在, :media_avatars => [] 这个字段里面以数组的形式上传, 
  # 每个资源包括description 字段和  media字段
  def work_review_params
    params.require(:work_review).permit(:remark, :teacher_id, :home_work_id, :rate)
  end
end