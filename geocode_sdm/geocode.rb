
require 'rubygems'
require 'geocoder'
Geocoder::Configuration.timeout = 30

data = File.open('address.txt')
File.open('LatLong', "w") do |f1|
  data.each do |x|
    y = Geocoder.search(x)
    y.each do |z|
      f1.puts x+", "+z.latitude.to_s+", "+z.longitude.to_s
    end
  end
end
