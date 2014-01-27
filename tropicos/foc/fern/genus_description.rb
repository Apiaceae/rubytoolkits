# get taxon description and distribution content
require "nokogiri"
require "open-uri"


# 类群描述页面
taxonbaseurl = "http://www.efloras.org/florataxon.aspx?flora_id=2&taxon_id="

# 数据文件标题
title = "genusid | description\r\n"

arrg = IO.readlines("genus.txt")
rownum = arrg.length

# From genus.txt file get genus id
Taxa = Struct.new(:familyid, :id, :name, :namezh)
File.open("genus.txt",) do |file|
	taxon = []
	file.each do |line|
		familyid, id, name, namezh = line.chomp.split(/\s*\|\s*/)
		family << Taxa.new(familyid, id, name, namezh)
	end

	# build family description content
	File.open("family_description.txt", "w") do |file|
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






