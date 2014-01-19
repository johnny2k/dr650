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
    nearby = ["bellingham", "bend", "corvallis", "eastoregon", "eugene", "klamath", "lewiston", "medford", "moseslake", "olympic", "oregoncoast", "portland", "pullman", "roseburg", "salem", "seattle", "siskiyou", "skagit", "spokane", "kpr", "wenatchee", "yakima"] 
    nearby.each do |place|
      if Craigslist.valid_city?(place) then
        dr_650 = Craigslist.city(place).category(:motorcycles).query("dr 650").fetch(100)
        dr650 = Craigslist.city(place).category(:motorcycles).query("dr 650").fetch(100)
        bikes = dr_650 + dr650

        if !bikes.empty? then
          bikes.each do |bike|
            found_bike = Bike.new(bike)
            if /dr(\s|.)?650/i.match(bike["text"]) then
              puts "Found a dr650"
              if !/^http/.match(bike["href"])
                real_url = "http://#{place}.craigslist.com#{bike["href"]}"
                found_bike.href = real_url
              end
              found_bike.save! 
            end
          end
        end
      else
        raise("#{place} is not a valid city")
      end      
    end
  end

  def cities_nearby city
    page = `curl http://sfbay.craigslist.org/`
    cities = nil
    return cities
  end
end
