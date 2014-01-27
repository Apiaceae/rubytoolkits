# get species description and distribution content
require "nokogiri"
require "open-uri"


# 类群描述页面
taxonbaseurl = "http://www.efloras.org/florataxon.aspx?flora_id=2&taxon_id="

# 数据文件标题
title = "speciesid | description\r\n"

arrs = IO.readlines("species.txt")

rownum = arrs.length

# From species.txt file get family id
Taxa = Struct.new(:genusid, :id, :name, :namezh)
File.open("species.txt",) do |file|
	taxon = []
	file.each do |line|
		genusid, id, name, namezh = line.chomp.split(/\s*\|\s*/)
		taxon << Taxa.new(genusid, id, name, namezh)
	end

	# build species description content
	File.open("species_description.txt", "w") do |file|
		file.puts title

		i = 1
		for i in 1..rownum
			pages = Nokogiri::HTML(open(taxonbaseurl+taxon[i].id), nil, "utf8")
			pages.encoding = 'utf-8'

			pages.css('span#lblTaxonDesc').each do |row|
				describ = row.search("p").text
				file.puts "#{taxon[i].id} | #{describ}\r\n"
				i+1
			end
		end
	end
end






