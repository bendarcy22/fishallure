class CatchesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @catches = Catch.order(caught_at: :desc)
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

    if params[:catch][:fish_type].present?
      @catch.fish_type = FishType.find(params[:catch][:fish_type])
    end

    if params[:catch][:lure].present?
      @catch.lure = Lure.find(params[:catch][:lure])
    end

    if @catch.save
      flash[:notice] = "Your catch has been recorded!"
      redirect_to catches_path(@catch)
    else
      flash[:errors] = @catch.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def catch_params
    params.require(:catch).permit(
      :caught_at,
      :zipcode
    )
  end
end
