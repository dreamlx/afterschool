class ToolsController < ApplicationController

  def import_students
  end

  def do_import_students
  	if params[:school_class] and params[:students]
  		@valid = true
	  	@sc = params[:school_class]
	  	@is_old_class = SchoolClass.find_by_class_no @sc
	  	if !@is_old_class
		  	@students = params[:students].read.force_encoding("UTF-8")
		  	process_students
		  end
		else 
			@valid = false
		end
  end

  private

  def process_students
  end

end
