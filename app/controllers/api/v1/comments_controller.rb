class Api::V1::CommentsController < Api::V1::BaseController

  respond_to :json

  def index
    post = Post.find params[:post_id]
    @comments = paged post.post_comments
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
  end

  def update
    @comment = PostComment.find(params[:id])
    @comment.update!(comment_params)
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy!
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :user_id, :post_id)
  end

end

