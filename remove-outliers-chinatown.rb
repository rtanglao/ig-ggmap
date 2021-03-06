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

first = true
ARGF.each do |line|
  if first
    first = false
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
  PP::pp(woeid_rsp, $stderr)
  
  place = woeid_rsp["places"]["place"]
  if place == []
    $stderr.printf("place is nil, skipping\n")
    next
  end
  
  woeid =  place[0]["woeid"]
  if woeid != "91977405"
    $stderr.printf("WOEID is %s, SKIPPING\n", woeid)
    next
  end
  puts(line)
  sleep(0.5)
  
end
