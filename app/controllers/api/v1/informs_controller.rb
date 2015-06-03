class Api::V1::InformsController < Api::V1::BaseController

  respond_to :json
  
  inherit_resources

  # def index
  #   @informs = Inform.all
  #   render json: { informs: @informs }
  # end

  private

    def inform_params
      params.require(:inform).permit!
    end

end
