class Api::V1::MediaResourcesController < Api::V1::BaseController
  respond_to :json

  def index
    @media_resources = MediaResource.paginate(:page => page, :per_page => 12)

    render json: { media_resources: @media_resources }, status: 200
  end

  def show 
    @media_resource = MediaResource.find(params[:id])

    render json: { media_resource: @media_resource }, status: 200
  end

  def create
    @media_resource = MediaResource.new(media_resource_params)

    if @media_resource.save
      render json: { media_resource: @media_resource }, status: 200
    else
      render json: { media_resource: { error: "创建资源失败"} }, status: 401
    end
  ensure
    clean_tempfile
  end

  def update
    @media_resource = MediaResource.find(params[:id])
    if @media_resource.update(media_resource)
      render json: { media_resource: @media_resource }, status: 200
    else
      render json: { media_resource: { error: "更新资源失败" }}, status: 401
    end
  end

  def destroy 
    @media_resource = MediaResource.find(params[:id])
    @media_resource.destroy!

    render json: { media_resource: @media_resource }, status: 204
  end

  private

  def media_resource_params
    _the_params = params.require(:media_resource).permit(:description, :avatar, :work_paper_id)
    _the_params[:avatar] = parse_data(_the_params[:avatar]) if _the_params[:avatar]
    _the_params
  end
end