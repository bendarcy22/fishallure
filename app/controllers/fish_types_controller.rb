class FishTypesController < ApplicationController
  def hot
    @catches = Catch.all
    @fishes = Hash.new(0)
    @catches.each { |c| @fishes[c.fish_type] += 1 }
    @hottest_fishes = @fishes.sort_by{ |_k, v| v }.reverse
  end

  def show
    @fish = FishType.find(params[:id])
    lures = @fish.lures
    sorted_lures = Hash.new(0)
    lures.each { |lure| sorted_lures[lure] += 1 }
    @lures_for_fish = sorted_lures.sort_by { |_k, v| v }.reverse
  end
end
