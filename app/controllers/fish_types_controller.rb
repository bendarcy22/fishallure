class FishTypesController < ApplicationController
  def hot
    @catches = Catch.all
    @fishes = Hash.new(0)
    @catches.each { |c| @fishes[c.fish_type] += 1 }
    @hottest_fishes = @fishes.sort_by{ |_k, v| v }.reverse
  end
end
