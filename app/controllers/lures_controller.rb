class LuresController < ApplicationController
  def index
    @lures = Lure.all
  end
  def hot
    @catches = Catch.all
    @lures = Hash.new(0)
    @catches.each { |c| @lures[c.lure] += 1 }
    @hottest_lures = @lures.sort_by{|k, v| v}.reverse
  end
end
