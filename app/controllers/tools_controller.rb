class ToolsController < ApplicationController

  def import_students
  end

  def do_import_students
  	if !params[:school_class].blank? and params[:students]
	  	@sc = params[:school_class]
	  	@is_old_class = SchoolClass.find_by_class_no @sc
	  	if !@is_old_class
		  	@students = params[:students].read.force_encoding("UTF-8")
		  	process_students
		  else
		  	flash.now[:error] = "#{@sc}班级已经存在！"
		  end
		else 
			flash.now[:error] = '输入不完整！'
		end
  end

  private

  def process_students
  end

end
