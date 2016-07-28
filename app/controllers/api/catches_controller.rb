class Api::CatchesController < ApiController
  def index
    catches = Catch.all
    render json: { catches: catches }, status: :ok
  end
  def personal
    catches = Catch.where("user": current_user)
    render json: { catches: catches }, status: :ok
  end
end
