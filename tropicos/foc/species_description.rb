# get fern species synonyms and distribution

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
content_title = "speciesid | content\r\n"

species_id_list = []

# 获取种名id
File.foreach("species_list.txt") do |row|
	genusid, speciesid, latinname, namezh = row.chomp.split(/\s*\|\s*/)
	species_id_list << speciesid
	species_id_list.compact.uniq
end

sp_number = species_id_list.length
p_tag = []

# build species synonyms and distribution file
File.open("species_description.txt", "w") do |line|
	line.puts content_title


	for j in 1..sp_number
		pages = Nokogiri::HTML(open(BASE_URL+TAXON_PAGE_URL+species_id_list[j].to_s), nil, "utf-8")
		pages.encoding = "utf-8"

		
		pages.css('div#panelTaxonTreatment p').each do |row|
			p_tag << row.text.to_s.gsub(/^\R/, '') unless row.text.length < 1
			# p_tag.compact.uniq
		end	

		p_num = p_tag.length

		for i in 0..(p_num-1)
			line.puts species_id_list[j]+" | "+p_tag[i] if p_tag[i].strip.length > 2
			# else puts "find empty cotent in p_tag!"
		end
		p_tag = []
		puts "The content of the species with id=#{species_id_list[j]} was successfully processed!"
		puts "\t...total #{j} species processed..."
		sleep 1.0 + rand
	end
end
puts "\t... congratulations!!! species content successfully build!"
	