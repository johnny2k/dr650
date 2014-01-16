class BikeSearchController < ApplicationController

  def index
    @bikesearch = Bike.new
  end

end
