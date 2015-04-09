class Api::V1::WorkReviewsController < Api::V1::BaseController

  respond_to :json

  def index
    teacher_id = params[:teacher_id]
    if teacher_id
      work_reviews = Teacher.find(teacher_id).work_reviews
    else
      work_reviews = WorkReview
    end
    @work_reviews = paged work_reviews
    render json: {work_reviews: @work_reviews}  
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def show
    @work_review = HomeWork.find(params[:home_work_id]).work_review
    render json: { work_review: @work_review }
  end

  # def create
  #   work = HomeWork.find(params[:home_work_id])
  #   @work_review = work.build_work_review(work_review_params)
  #   if @work_review.save
  #     work.state = 'complete'
  #     work.save!
  #     render json: {work_review: @work_review}
  #   else
  #     render json: {message: @work_review.errors}, status: 400, message: '更新失败，请联系管理员'
  #   end
  # rescue ActiveRecord::RecordNotFound => e
  #   render json: { error: { message: 'No found' } }, status: 400
  # end

  def batch_review
    wp_id = params[:work_paper_id]
    works = HomeWork.where("work_paper_id = #{wp_id}")
    works.each do |work|
      update_review(work) if work.state == 'init'
    end
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def update
    @review = HomeWork.find(params[:home_work_id]).work_review
    if @review.update(work_review_params)
      render json: { review: @review }
    else
      render json: { error: @review.errors }
    end
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def destroy
    @work_review = HomeWork.find(params[:home_work_id]).work_review
    @work_review.destroy!
    render json: { message: 'deleted' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  private

  def update_review(work)
    params[:work_review][:home_work_id] = work.id
    work.work_review.update(work_review_params)
    work.save!
  end

  def work_review_params
    params.require(:work_review).permit(:remark, :teacher_id, 
      :home_work_id, :rate)
  end
end

  # 创建照片的同时也要创建资源
  # 资源都放在, :media_avatars => [] 这个字段里面以数组的形式上传, 
  # 每个资源包括description 字段和  media字段