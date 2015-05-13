class Api::V1::PostsController < Api::V1::BaseController

  respond_to :json

  def index
    if params[:school_class_id]
      cid = params[:school_class_id]
      @posts = paged Post.where("school_class_id=#{cid}")
    elsif params[:student_id]
      sid = params[:student_id]
      @posts = paged Post.where("user_id=#{sid}")
    end

    @media = @posts.map do |p|
      media_urls = p.media_resources.map do |m|
        m.avatar.url
      end
      {}.tap do |media|
        media[:post_id] = p.id
        media[:urls] = media_urls
      end
    end
    render json: { posts: @posts, media_resources: @media }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def create
    @post = Post.new(post_params)

    params[:media_resource][:avatar].each do |a|
      @post.media_resources.build( { avatar: a } )
    end if params[:media_resource]

    @post.save!
    render json: { message: 'OK' }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def show
    @post = Post.find(params[:id])
    @post.user.authentication_token = 'hiddden'
    @comment_profiles = @post.post_comments.map do |c|
      {}.tap do |cp|
        cp[:id] = c.id
        cp[:nickname] = c.user.nickname
        cp[:avatar] = c.user.profile.avatar.url
      end
    end
    render json: { post: @post, comments: @post.post_comments,
      comment_profiles: @comment_profiles, user: @post.user }
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def update
    @post = Post.find(params[:id])

    params[:media_resource][:avatar].each do |a|
      @post.media_resources.build({avatar: a})
    end if params[:media_resource]

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

  # def media_params
  #   params.require(:media_resource[]).permit(:avatar)
  # end

end
