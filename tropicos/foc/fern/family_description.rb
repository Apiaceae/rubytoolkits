# get taxon description and distribution content
require "nokogiri"
require "open-uri"


# 类群描述页面
taxonbaseurl = "http://www.efloras.org/florataxon.aspx?flora_id=2&taxon_id="

# 数据文件标题
title = "familyid | description\r\n"

# 蕨类科列表页面
uri = "http://www.efloras.org/browse.aspx?volume_id=2002"

# 下级类群列表页面
childurl = "http://www.efloras.org/browse.aspx?flora_id=2&start_taxon_id="

doc = Nokogiri::HTML(open(uri), nil, "utf8")
doc.encoding = 'utf-8'


# From family.txt file get family id
Family = Struct.new(:id, :name, :namezh)
File.open("family.txt",) do |file|
	family = []
	file.each do |line|
		id, name, namezh = line.chomp.split(/\s*\|\s*/)
		family << Family.new(id, name, namezh)
	end

	# build family description content
	File.open("family_description.txt", "w") do |file|
		file.puts title

		i = 1
		for i in 1..39
			pages = Nokogiri::HTML(open(taxonbaseurl+family[i].id), nil, "utf8")
			pages.encoding = 'utf-8'

			pages.css('span#lblTaxonDesc').each do |row|
				describ = row.search("p").text
				file.puts "#{family[i].id} | #{describ}\r\n"
				i+1
			end
		end
	end
end






