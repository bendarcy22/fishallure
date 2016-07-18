class CatchesController < ApplicationController
  def index
    @catches = Catch.order(caught_at: :desc)
  end

  def show
    @catch = Catch.find(params[:id])
  end
end
