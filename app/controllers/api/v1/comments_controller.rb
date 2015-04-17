class Api::V1::CommentsController < Api::V1::BaseController

  respond_to :json

  def index
    post = Post.find params[:post_id]
    @comments = paged post.comments
    render json: { comments: @comments }  
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def create
    @comment = PostComment.new(comment_params)
    @comment.save!
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


  def comment_params
    params.require(:comment).permit(:title, :body, :user_id, :post_id)
  end

end

