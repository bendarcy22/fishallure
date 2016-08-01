class Api::FishTypesController < ApiController
  def show
    fish = FishType.find(params[:id])
    catches = fish.catches
    render json: { catches: catches }, status: :ok
  end
end
