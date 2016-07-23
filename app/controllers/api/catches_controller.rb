class Api::CatchesController < ApiController
  def index
    catches = Catch.all
    render json: { catches: catches }, status: :ok
  end
end
