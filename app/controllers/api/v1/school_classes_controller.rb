class Api::V1::SchoolClassesController < Api::V1::BaseController
  respond_to :json

  def index

    if params[:teacher_id]
      classes = Teacher.find(params[:teacher_id]).school_classes
      @classes = classes.paginate(:page => params[:page], :per_page => 60)
    else
      @classes = SchoolClass.paginate(:page => params[:page], :per_page => 60) 
    end

    # classes = Teacher.find(params[:teacher_id]).school_classes unless params[:teacher_id].blank?
    # if classes.nil?
    #   @classes = SchoolClass.paginate(:page => params[:page], :per_page => 60) 
    # else
    #   @classes = classes.paginate(:page => params[:page], :per_page => 60)
    # end    
  
    render json: { school_classes: @classes }
  end

  def show
  	@sc = SchoolClass.find(params[:id])
  	render json: { 	school_class: @sc, 
  					teachers: @sc.teachers, 
  					students: @sc.students 
  	}, status: 200
  end
end