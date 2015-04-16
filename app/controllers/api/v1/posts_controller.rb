class Api::V1::PostsController < Api::V1::BaseController

  respond_to :json

  def index
    @posts = paged Post
    render json: {posts: @posts}  
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def create
    @post = Post.new(post_params)
    @post.save!
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: @post }
  end

  def update
    @review = HomeWork.find(params[:home_work_id]).work_review
    @review.media_resources.build(media_params) if params[:media_resource]
    if @review.update(work_review_params)
      @review.home_work.state = 'complete'
      @review.home_work.save!
      render json: { review: @review, review_medias: @review.media_resources }
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


  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

end

  # 创建照片的同时也要创建资源
  # 资源都放在, :media_avatars => [] 这个字段里面以数组的形式上传, 
  # 每个资源包括description 字段和  media字段


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

