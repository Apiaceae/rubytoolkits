# get genus name list by family name

require "nokogiri"
require "open-uri"
require 'ruby-progressbar'

# 被子植物科列表页面
BASE_URL = "http://www.theplantlist.org"
FAMILY_LIST_URL = "/browse/A/"

# 数据文件标题
content_title = "familyname | genusname\r\n"

# get family name array
arrf = IO.readlines("tpl_family_list.txt")
fam_number = arrf.length

# ProgressBar.create(:format => '%a %B %p%% %t')
File.open("tpl_genus_list.txt", "w") do |file|
	file.puts content_title

	for i in 1..fam_number
		pages = Nokogiri::HTML(open(BASE_URL+FAMILY_LIST_URL+arrf[i]), nil, "utf-8")
		pages.encoding = "utf-8"

		pages.css("i[class='genus']").each do |line|
			genusname = line.text
			file.puts arrf[i].chop+" | "+genusname+"\r\n"
		end
		puts "The genus list of #{arrf[i]} successfully processed!"
		puts "\t...total #{i} family processed!"
		sleep 1.0 + rand
	end
end