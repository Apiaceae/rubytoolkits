# get fern species name list

require "nokogiri"
require "open-uri"


# FOC 网站主页面
BASE_URL = "http://www.efloras.org"

# 类群描述页面
TAXON_PAGE_URL = "/florataxon.aspx?flora_id=2&taxon_id="

# 蕨类科列表页面
FERN_FAM_LIST_URL = "/browse.aspx?flora_id=2&volume_id=2002"

# 下级类群列表页面
CHILD_LIST_URL = "/browse.aspx?flora_id=2&start_taxon_id="


# 数据文件标题
content_title = "genusid | speciesid | latinname | namezh\r\n"

genus_id_list = []

# 获取属名ID
File.foreach("genus_list.txt") do |row|
	familyid, genusid, latinname, namezh, lowertaxa = row.chomp.split(/\s*\|\s*/)
	genus_id_list << genusid
end

gen_number = genus_id_list.length


# build species name list file
File.open("species_list.txt", "w") do |line|
	line.puts content_title
	for i in 1..gen_number
		pages = Nokogiri::HTML(open(BASE_URL+CHILD_LIST_URL+genus_id_list[i].to_s), nil, "utf-8")
		pages.encoding = "utf-8"

		pages.css('tr.class=underline').each do |row|
			speciesid = row.search("td[1]").text
			latinname = row.search("td[2]").text
			namezh = row.search("td[3]").text

			line.puts "#{genus_id_list[i]} | #{speciesid} | #{latinname} | #{namezh}\r\n" if speciesid.to_i > 1
		end
		puts "The species list of the genus with id=#{genus_id_list[i]} was successfully processed!"
		sleep 1.0 + rand
	end
end	
puts "\t...species list successfully build!"