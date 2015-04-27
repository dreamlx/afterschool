class Api::V1::WorkPapersController < Api::V1::BaseController

  respond_to :json

  # before_action :verify_teacher, only: [:create, :update, :destroy]
  
  def index
    tid, cid, sid = params[:teacher_id], params[:school_class_id], params[:student_id]
    total_students = 0

    if !tid.blank? and !cid.blank?
      cond = "teacher_id=#{tid} and class_papers.school_class_id=#{cid}"
      work_papers = WorkPaper.joins(:school_classes).where(cond)
      total_students = Student.of_class(cid).count
    elsif !sid.blank?
      work_papers = Student.find(sid).work_papers
    elsif !tid.blank?
      work_papers = Teacher.find(tid).work_papers
      total_students = Teacher.find(tid).school_classes.reduce(0) do |resu, sc|
        resu + Student.of_class(sc.id).count
      end
    elsif !cid.blank?
      work_papers = SchoolClass.find(cid).work_papers
      total_students = Student.of_class(cid).count
    end    

    work_papers = WorkPaper if work_papers.nil?
    @work_papers = paged work_papers.order(updated_at: :desc)

    @work_papers.each do |wp|
      wp.count_works = wp.home_works.count 
      wp.total_students = total_students 
    end
    render json:  format_papers(@work_papers, sid)
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def show
    @work_paper = WorkPaper.find(params[:id])
    render json: format_paper(@work_paper)
  end

  def create
    @work_paper = Teacher.find(params[:teacher_id]).work_papers.build(work_paper_params)
    params[:school_class_ids].each do |cid|
      @work_paper.class_papers.build(school_class_id: cid)
    end if params[:school_class_ids]
    @work_paper.save!
    render json: format_paper(@work_paper)
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  def update
  end

  def destroy
    @work_paper = WorkPaper.find(params[:id])
    @work_paper.destroy!
    render json: format_paper(@work_paper)
  rescue Exception => e
    render json: { error: { message: e.message } }
  end

  private

  def work_paper_params
    params.require(:work_paper).permit(:title, :description, :paper_type)
  end

  # def class_paper_params
  #   params.require(:work_paper).permit(:school_class_id, :work_paper_id)
  # end

  def verify_teacher
    @techer = Teacher.find(params[:teacher_id])
    if @teacher 
      return true
    end
    return false 
  end
  
end

