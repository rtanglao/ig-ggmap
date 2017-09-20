#!/usr/bin/env ruby
require 'rubygems'
require 'parseconfig'
require 'pp'
require 'typhoeus'
require 'json'

def getFlickrResponse(url, params)
  url = "https://api.flickr.com/" + url
  result = Typhoeus::Request.get(url,
             :params => params )
  return JSON.parse(result.body)
end

flickr_config = ParseConfig.new('flickr.conf').params
api_key = flickr_config['api_key']

# pp api_key

first = TRUE
ARGF.each do |line|
  if first
    first = FALSE
    printf("colour,lat,long,date,neighbourhood\n")
    next
  end
  averagecolour_lat_lon_date = line.chomp
  fields = averagecolour_lat_lon_date.split(',')
  lat = fields[1]
  lon = fields[2]

  base_url = "services/rest/"
  
  url_params = {:method => "flickr.places.findByLatLon",
      :api_key => api_key,
      :format => "json",
      :nojsoncallback => "1",
      :lat => lat,
      :lon => lon
    }
  woeid_rsp = getFlickrResponse(base_url, url_params)
  #pp woeid_rsp
  woe_name =  woeid_rsp["places"]["place"][0]["woe_name"]

  printf("%s,%s\n",  averagecolour_lat_lon_date, woe_name)
  
end
