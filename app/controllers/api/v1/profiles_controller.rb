class Api::V1::ProfilesController < Api::V1::BaseController
  respond_to :json

  def show
  	id = params[:user_id] unless params[:user_id].blank?
  	id = params[:student_id] unless params[:student_id].blank?
  	@profile = User.find(id).profile
  	render json: { profile: @profile}, status: 200
  end

    # 通过params 取到当前的profile
  def update
  	id = params[:user_id] unless params[:user_id].blank?
  	id = params[:student_id] unless params[:student_id].blank?
    id = params[:teacher_id] unless params[:teacher_id].blank?
  	@profile = User.find(id).profile
    @profile.user.email = params[:profile][:email] if params[:profile][:email]
    @profile.user.school_class_id = params[:profile][:school_class_id] if params[:profile][:school_class_id]

  	if @profile.update!(profile_params)
      @profile.user.save!
  		render json: { profile: @profile}, status: 201, message: '更新成功'
  	else
  		render json: { profile: @profile}, status: 400, message: '更新失败，请联系管理员'
  	end
  end

  def replace_avatar
    id = params[:user_id] unless params[:user_id].blank?
    id = params[:student_id] unless params[:student_id].blank?
    id = params[:teacher_id] unless params[:teacher_id].blank?
  	p = User.find(id).profile

  	p.avatar = params[:profile][:avatar] # Assign a file like this, or

  	if p.save!
  		render json:{ profile: p }, status: 201, message: '更新成功'
  	else
  		render json: { profile: p}, status: 400, message: '更新失败，请联系管理员'
  	end

  end


  private

    def profile_params
    	params.require(:profile).permit(
        	:user_id,
        	:address,
        	:birthday,
        	:postalcode,
        	:gender,
        	:student_number,
        	:avatar
        )

    end
end
