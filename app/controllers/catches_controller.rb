class CatchesController < ApplicationController
  def index
    @catches = Catch.order(caught_at: :desc)
  end
end
