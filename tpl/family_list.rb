# get Angiosperm family name list

require "nokogiri"
require "open-uri"

# 被子植物科列表页面
BASE_URL = "http://www.theplantlist.org"
FAMILY_LIST_URL = "/browse/A/"

# 数据文件标题
content_title = "familyname\r\n"

pages = Nokogiri::HTML(open(BASE_URL+FAMILY_LIST_URL), nil, "utf-8")
pages.encoding = "utf-8"

# build family name list file
File.open("tpl_family_list.txt", "w") do |file|
	file.puts content_title

	pages.css("i[class='family']").each do |line| 
		familyname = line.text
		file.puts "#{familyname}"
	end
end
puts "\t...Congratulation, family list successfully processed!"
