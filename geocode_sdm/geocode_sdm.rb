
require 'rubygems'
require 'geocoder'

Geocoder::Configuration.timeout = 30


record_id_list = []
species_list = []
address_list = []
source_list = []


content_title = "id | species | address | source | latitude | longitude\r\n"

File.foreach("cryptotaenia03.txt") do |row|
  id, species, address, source = row.chomp.split(/\s*\|\s*/)
  record_id_list << id
  species_list << species
  address_list << address
  source_list << source
end

line_number = record_id_list.length

File.open('cryptotaenia_geocode_03.txt', "w") do |f1|
  f1.puts content_title
  for i in 1..line_number
    y = Geocoder.search(address_list[i])
    y.each do |z|
      f1.puts "#{record_id_list[i].to_s} | #{species_list[i]} | #{address_list[i]} | #{source_list[i]} | #{z.latitude.to_s} | #{z.longitude.to_s}\r\n"
    end
    puts "\t...total #{i} records processed..."
    sleep 1.0 + rand
  end
end
puts "\t... congratulations!!! All records were successfully geocoded!"
