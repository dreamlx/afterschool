class Api::V1::HomeWorksController < Api::V1::BaseController
  respond_to :json

  def index
  	@homeworks = HomeWork.all

  	render json: { homeworks: @homeworks}
  end

end