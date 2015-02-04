class Api::V1::WorkPapersController < Api::V1::BaseController
  respond_to :json

  before_action :verify_teacher, only: [:create, :update, :destroy]

  def index
  end

  def show
    @work_paper = WorkPaper.find(params[:id])

    render json: { work_paper: @work_paper }, status: 200
  end

  # TODO 创建做的时候同时要创建资源
  def create
    @work_paper = @teacher.work_papers.build(work_paper_params)

    if @work_paper.save!

    else

    end

  end

  def update

  end

  def destroy

  end

  private
  # 创建照片的同时也要创建资源
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