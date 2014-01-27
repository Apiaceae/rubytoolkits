# dowload species name list page to local disk
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

BASE_URL = "http://www.efloras.org"
BASE_DIR = "/browse.aspx?flora_id=2&start_taxon_id=&page=1"
LOCAL_DIR = "data-hold/species-list-pages"

FileUtils.makedirs(LOCAL_DIR) unless File.exists?LOCAL_DIR

# get metainfo from first page:
page = Nokogiri::HTML(open(BASE_URL+BASE_DIR + '1'))

# write the HTML for page 1 to disk
File.open("#{LOCAL_DIR}/1.html", 'w'){|f| f.write(page.to_html)}

last_page_number = page.css("a.end.lastLink.button")[0]['href'].match(/page=(\d+)/)[1].to_i

puts "Iterating from 2 to #{last_page_number}"

for pg_number in 2..last_page_number do
  puts "Getting #{pg_number}"
  File.open("#{LOCAL_DIR}/#{pg_number}.html", 'w') do |f| 
    f.write( open("#{BASE_URL}#{BASE_DIR}#{pg_number}").read )
  end
end