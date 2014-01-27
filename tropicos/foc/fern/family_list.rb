# get fern family name list

require 'nokogiri'
require 'open-uri'


# FOC 网站主页面
BASE_URL = "http://www.efloras.org"

# 类群描述页面
TAXON_PAGE_URL = "/florataxon.aspx?flora_id=2&taxon_id="

# 蕨类科列表页面
FERN_FAM_LIST_URL = "/volume_page.aspx?volume_id=2002&flora_id=2"


# 数据文件标题
content_title = "familyid | latinname | namezh | lowertaxa\r\n"

pages = Nokogiri::HTML(open(BASE_URL+FERN_FAM_LIST_URL), nil, "utf-8")
pages.encoding = "utf-8"

# build family name list file
File.open("family_list.txt", "w") do |file|
	file.puts content_title

	pages.css('tr.underline').each do |row|
		familyid = row.search('td[1]').text
		latinname = row.search('td[2]').text
		namezh = row.search('td[3]').text
		lowertaxa = row.search('td[4] a').text

		file.puts "#{familyid} | #{latinname} | #{namezh} | #{lowertaxa}\r\n" if familyid.to_i > 1
	end
	puts "\t..Processing successfully!"
end	
