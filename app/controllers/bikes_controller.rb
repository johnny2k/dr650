class BikesController < ApplicationController
require 'craigslist'

  def index
    if Bike.all.empty? then
       search_all_nearby_for_bikes
    else 
       @bikes = Bike.all
    end   
  end

  def search_all_nearby_for_bikes
    nearby = ["bellingham", "bend", "comoxvalley", "corvallis", "eastoregon", "eugene", "abbotsford", "kelowna", "klamath", "lewiston", "medford", "moseslake", "nanaimo", "olympic", "oregoncoast", "portland", "pullman", "roseburg", "salem", "seattle", "siskiyou", "skagit", "spokane", "sunshine", "kpr", "vancouver", "victoria", "wenatchee", "whistler", "yakima"] 
    nearby.each do |place|
      Craigslist.city(place).motorcycles.fetch(1000).each do |bike|
        found_bike = Bike.new(bike)
        if !bike["href"].nil? then
          found_bike["href"] = "#{place}.craigslist.com#{bike["href"]}"
        end
	if /dr(\s|.)?650/i.match(bike[:text]) then 
	  found_bike.save!
	end
      end
    end
  end
end
