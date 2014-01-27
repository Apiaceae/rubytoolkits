# get all family name list
# this file is definitely necessary as you can 
# mannually copy family list name from the website
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'


BASE_URL = "http://www.efloras.org"
TAXON_PAGE_URL = "/florataxon.aspx?flora_id=2&taxon_id="
CHILD_LIST_URL = "/browse.aspx?flora_id=2&start_taxon_id="
BASE_DIR = "/browse.aspx?flora_id=2&page=2"

content_title = "familyid | latinname | namezh | lowertaxa | focvolume\r\n"


# get metainfo from first page
pages = Nokogiri::HTML(open(BASE_URL+BASE_DIR), nil, 'utf-8')
pages.encoding = 'utf-8'


File.open("family_list2.txt", 'w') do |file|
  puts "Fetching #{BASE_URL}..."
  file.puts "#{content_title}"


  pages.css('tr.underline').each do |row|
    familyid = row.search("td[1]").text
    latinname = row.search("td[2]").text
    namezh = row.search("td[3]").text
    lowertaxa = row.search("td[4] a").text 
    focvolume = row.search("td[5]").text

    file.puts "#{familyid} | #{latinname} | #{namezh} | #{lowertaxa} | #{focvolume}\r\n" if familyid.to_i > 1
  end
  puts "\t...Family list successfully processed!"
end
