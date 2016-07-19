class LuresController < ApplicationController
  def index
    @lures = Lure.all
  end

  def hot
    @catches = Catch.all
    @lures = Hash.new(0)
    @catches.each { |c| @lures[c.lure] += 1 }
    @hottest_lures = @lures.sort_by { |_k, v| v }.reverse
  end

  def show
    @lure = Lure.find(params[:id])
    fishes = @lure.fish_types
    sorted_fish = Hash.new(0)
    fishes.each { |fish| sorted_fish[fish] += 1 }
    @fish_on_lure = sorted_fish.sort_by { |_k, v| v }.reverse
  end
end
