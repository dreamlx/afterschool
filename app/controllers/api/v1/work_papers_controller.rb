class Api::V1::WorkPapersController < Api::V1::BaseController
  respond_to :json

  # before_action :verify_teacher, only: [:create, :update, :destroy]

  def index
    @work_papers = WorkPaper.paginate(:page => params[:page], :per_page => 12)

    render json: { work_papers: @work_papers }, status: 200
  end

  def show
    @work_paper = WorkPaper.find(params[:id])

    render json: { work_paper: @work_paper }, status: 200
  end

# 可能由于临时文件的问题 这个要修改
  def create
    @work_paper = @teacher.work_papers.build(work_paper_params)
    if @work_paper
      params[:media_avatars].each do |media_avatar|
        _description = media_avatar[:description] if media_avatar[:description]
        _avatar = parse_data(media_avatar[:avatar]) if media_avatar[:avatar]
        @work_paper.media_resources.build(description: _description, avatar: _avatar)
      end
      if @work_paper.save
        render json: { work_paper: @work_paper }, status: 201
      else
        render json: { error: { message: "创建作业失败, 请检查您的媒体文件" } }, status: 400
      end
    else
      render json: { error: { message: "创建作业失败, 请核实您的身份" } }, status: 400
    end

  end

  def update

  end

  def destroy
    @work_paper =  WorkPaper.find(params[:id])
    @work_paper.destroy!

    render json: { work_paper: @work_paper }
  end

  private
  # 创建照片的同时也要创建资源
  # 资源都放在, :media_avatars => [] 这个字段里面以数组的形式上传, 
  # 每个资源包括description 字段和  media字段
  def work_paper_params
    params.require(:work_paper).permit(:title, :description, :paper_type)
  end

  def verify_teacher
    @techer = Teacher.find(params[:teacher_id])
    if @teacher # && @teacher.status == 'active'
      return true
    end
    return false #TODO应该返回 teacher not found or unactive的消息
  end
  
end