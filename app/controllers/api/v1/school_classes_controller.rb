class Api::V1::SchoolClassesController < Api::V1::BaseController
  respond_to :json

  def index

    if params[:teacher_id]
      classes = Teacher.find(params[:teacher_id]).school_classes
      @classes = classes.page(params[:page]).per(60)
    else
      @classes = SchoolClass.page(params[:page]).per(60)
    end   
  
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