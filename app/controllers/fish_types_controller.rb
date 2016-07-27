class FishTypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :hot, :show]
  def index
    @fishes = FishType.all
  end

  def hot
    if params["l"].present?
      @lure = Lure.where("name ILIKE ?", "%#{params[:l]}%")
      if @lure.present?
        @catches = Catch.where("lure": @lure)
      else
        render :hot
      end
    else
      @catches = Catch.all
    end
    @fishes = Hash.new(0)
    @catches.each { |c| @fishes[c.fish_type] += 1 }
    @hottest_fishes = @fishes.sort_by { |_k, v| v }.reverse
  end

  def show
    @fish = FishType.find(params[:id])
    lures = @fish.lures
    sorted_lures = Hash.new(0)
    lures.each { |lure| sorted_lures[lure] += 1 }
    @lures_for_fish = sorted_lures.sort_by { |_k, v| v }.reverse
  end

  def new
    @fish = FishType.new
  end

  def create
    @fish = FishType.new(fish_params)
    if FishType.find_by(name: params[:fish_type][:name]).nil?
      @fish.user = current_user
      if @fish.save
        flash[:notice] = "The Fish has been added!"
        redirect_to fish_type_path(@fish)
      else
        flash[:errors] = @fish.errors.full_messages.join(", ")
        render :new
      end
    else
      flash[:errors] = "That fish is already in the database"
      render :new
    end
  end

  private

  def fish_params
    params.require(:fish_type).permit(
      :name,
      :description,
      :fish_photo
    )
  end
end
