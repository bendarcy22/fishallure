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
  end
end
