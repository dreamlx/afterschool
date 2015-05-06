class Api::V1::PostsController < Api::V1::BaseController

  respond_to :json

  def index
    cid = params[:school_class_id]
    @posts = paged Post.where("school_class_id=#{cid}")
    @media = @posts.map do |p|
      media_urls = p.media_resources.map do |m|
        m.avatar.url
      end
      OpenStruct.new.tap do |media|
        media.post_id = p.id
        media.url = media_urls
      end
    end

    # render json: { posts: @posts }
    render json: { posts: @posts, media_resources: @media }
  # rescue Exception => e
  #   render json: { error: { message: e.message } }
  end

  def create
    @post = Post.new(post_params)

    @post.media_resources.build(media_params) if params[:media_resource]

    @post.save!
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def show
    @post = Post.find(params[:id])
    @post.user.authentication_token = 'hiddden'
    @comment_profiles = @post.post_comments.map do |c|
      OpenStruct.new.tap do |o|
       o.id = c.id
       o.nickname = c.user.nickname
       o.avatar = c.user.profile.avatar.url
      end
    end
    render json: { post: @post, comments: @post.post_comments,
      comment_profiles: @comment_profiles, user: @post.user }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def update
    @post = Post.find(params[:id])

    @post.media_resources.build(media_params) if params[:media_resource]

    @post.update!(post_params)
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :school_class_id)
  end

  def media_params
    params.require(:media_resource).permit(:avatar)
  end

end
