class Api::V1::PostsController < Api::V1::BaseController

  respond_to :json

  def index
    cid = params[:school_class_id]
    @posts = paged Post.where("school_class_id=#{cid}")
    render json: { posts: @posts }  
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
    @post.user.authentication_token = 'hiddden'
    render json: { post: @post, user: @post.user }
  rescue Exception => e
    render json: { error: { message: e.message } }
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
    params.require(:post).permit(:title, :body, :user_id, :school_class_id)
  end

end

