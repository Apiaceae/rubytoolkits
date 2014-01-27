# get species name list

require "nokogiri"
require "open-uri"

# 被子植物科列表页面
BASE_URL = "http://www.theplantlist.org"
FAMILY_LIST_URL = "/browse/A/"

# 数据文件标题
content_title = "speciesname | taxstat\r\n"

family_name_list = []
genus_name_list = []
# get genus name array
File.foreach("tpl_genus_list.txt") do |row|
	familyname, genusname = row.chomp.split(/\s*\|\s*/)
	genus_name_list << genusname
	family_name_list << familyname
end

gen_num = genus_name_list.length

File.open("tpl_species_list.txt", "w") do |file|
	file.puts content_title

	for i in 1..gen_num
		pages = Nokogiri::HTML(open(BASE_URL+FAMILY_LIST_URL+family_name_list[i]+"/"+genus_name_list[i]+"/"), nil, "utf-8")
		pages.encoding = "utf-8"

		pages.css('tr').each do |line|
			genusname = line.css("i.genus").text
			speciesname = line.css("i.species").text
			authors = line.css("span.authorship").text
			namestat = line.css('td[2]').text

			file.puts "#{genusname} #{speciesname} #{authors} | #{namestat}\r\n" if genusname.length > 1
		end	
		puts "Species list of the genus #{genus_name_list[i]} successfully processed!"
		puts "\t...total #{i} genus fetched!"
		sleep 1.0 + rand
	end
end
puts "\t...Congratulations! All species list sucessfully processed!"