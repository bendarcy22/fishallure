class CatchesController < ApplicationController
  before_action :authenticate_user!, except: [:recent, :index, :show]

  def recent
    if params["l"].present?
      @lure = Lure.where("name ILIKE ?", "%#{params[:l]}%")
      if @lure.present?
        @catches = Catch.where("lure": @lure)
      else
        render :recent
      end
    elsif params["f"].present?
      @fish = FishType.where("name ILIKE ?", "%#{params[:f]}%")
      if @fish.present?
        @catches = Catch.where("fish_type": @fish)
      else
        render :recent
      end
    else
      @catches = Catch.order(caught_at: :desc)
    end
  end

  def personal
    @catches = Catch.where("user": current_user)
  end

  def index
    @catches = Catch.all
  end

  def show
    @catch = Catch.find(params[:id])
  end

  def new
    @catch = Catch.new
  end

  def create
    @catch = Catch.new(catch_params)
    @catch.user = current_user
    if params[:catch][:fish_type].present? && params[:catch][:lure].present?
      @catch.fish_type = FishType.find(params[:catch][:fish_type])
      @catch.lure = Lure.find(params[:catch][:lure])
    end

    if @catch.save
      flash[:notice] = "Your catch has been recorded!"
      redirect_to catch_path(@catch)
    else
      flash[:errors] = @catch.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @catch = Catch.find(params[:id])
  end

  def update
    @catch = Catch.find(params[:id])
    if @catch.update_attributes(catch_params)
      flash[:notice] = "Your catch was updated successfully"
      redirect_to catch_path(@catch)
    else
      flash[:errors] = @catch.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
    @catch = Catch.find(params[:id])
    @catch.destroy
    flash[:notice] = "Catch deleted successfully"
    redirect_to catches_path
  end

  private

  def catch_params
    params.require(:catch).permit(
      :caught_at,
      :catch_photo,
      :latitude,
      :longitude
    )
  end
end
