class LuresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :hot, :show]

  def index
    @lures = Lure.all
  end

  def hot
    if params["f"].present?
      @fish = FishType.where("name ILIKE ?", "%#{params[:f]}%")
      if @fish.present?
        @search = params["f"]
        @catches = Catch.where("fish_type": @fish)
      else
        @search = params["f"]
        render :recent
      end
    else
      @catches = Catch.all
    end
    @lures = Hash.new(0)
    @catches.each { |c| @lures[c.lure] += 1 }
    @hottest_lures = @lures.sort_by { |_k, v| v }.reverse
  end

  def show
    @lure = Lure.find(params[:id])
    fishes = @lure.fish_types
    if fishes.present?
      sorted_fish = Hash.new(0)
      fishes.each { |fish| sorted_fish[fish] += 1 }
      @fish_on_lure = sorted_fish.sort_by { |_k, v| v }.reverse
    else
      @fish_on_lure = 0
    end
  end

  def new
    @lure = Lure.new
    @categories = Lure::CATEGORIES
  end

  def create
    @lure = Lure.new(lure_params)
    if Lure.find_by(name: params[:lure][:name]).nil?
      @lure.user = current_user
      if @lure.save
        flash[:notice] = "The Lure has been added!"
        redirect_to lure_path(@lure)
      else
        @categories = Lure::CATEGORIES
        flash[:errors] = @lure.errors.full_messages.join(", ")
        render :new
      end
    else
      @categories = Lure::CATEGORIES
      flash[:errors] = "That lure is already in the database"
      render :new
    end
  end

  private

  def lure_params
    params.require(:lure).permit(
      :name,
      :manufacturer,
      :category,
      :description,
      :lure_photo
    )
  end
end
