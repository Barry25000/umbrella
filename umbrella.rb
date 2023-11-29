require "http"
require "json"

pp "Where are you located?"

location = gets.chomp

user_location = location.gsub(" ", "%20")

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key="+ENV.fetch("GMAPS_KEY") 

resp = HTTP.get(maps_url)

raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")
  
loc = geo.fetch("location")

lat = loc.fetch("lat")
lng = loc.fetch("lng")

lats = lat.to_s
lngs = lng.to_s

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/"+ pirate_weather_api_key + "/" +lats +"," +lngs


raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature").round() 

acctual_temp = currently_hash.fetch("apparentTemperature").round()

precip_prob = currently_hash.fetch("precipProbability")

wind = currently_hash.fetch("windSpeed").round() 

wind_gust = currently_hash.fetch("windGust").round() 

puts "The current temperature in #{location} is " + current_temp.to_s + " degrees."
puts "The current feel like temperature in #{location} is " + acctual_temp.to_s + " degrees."
puts "The current precipitaion in #{location} is " + precip_prob.to_s + " inches."
puts "The current wind speed in #{location} is " + wind.to_s + " mph."
puts "The current wind gust speed in #{location} is " + wind_gust.to_s + " mph."
