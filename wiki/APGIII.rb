# get APG III classification

require "open-uri"
require "nokogiri"

BASE_WIKIPEDIA_URL = "http://en.wikipedia.org"
LIST_URL = "#{BASE_WIKIPEDIA_URL}/wiki/APG_III_system"

page = Nokogiri::HTML(open(LIST_URL))
rows = page.css('#mw-content-text > ul:nth-child(31)')

puts rows
