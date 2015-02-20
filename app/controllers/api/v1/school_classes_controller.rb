class Api::V1::SchoolClassesController < Api::V1::BaseController
  respond_to :json

  def index
  	@classes = SchoolClass.all

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