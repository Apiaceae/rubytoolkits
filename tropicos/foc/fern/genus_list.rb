# get fern genus name list

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
content_title = "familyid | genusid | latinname | namezh | lowertaxa\r\n"

# no_gen_name = [subfam. sect. ser. subg. ]

family_id_list = []

# 获取科名ID
File.foreach("family_list.txt") do |row|
	familyid, latinname, namezh, lowertaxa = row.chomp.split(/\s*\|\s*/)
	family_id_list << familyid
	family_id_list.compact.uniq
end

fam_number = family_id_list.length


# build genus name list file
File.open("genus_list.txt", "w") do |line|
	line.puts content_title
	for i in 1..fam_number
		pages = Nokogiri::HTML(open(BASE_URL+CHILD_LIST_URL+family_id_list[i].to_s), nil, "utf-8")
		pages.encoding = "utf-8"

		pages.css('tr.underline').each do |row|
			genusid = row.search("td[1]").text
			latinname = row.search("td[2]").text
			namezh = row.search("td[3]").text
			lowertaxa = row.search("td[4] a").text

			line.puts "#{family_id_list[i]} | #{genusid} | #{latinname} | #{namezh} | #{lowertaxa}\r\n" if genusid.to_i > 1
		end
		puts "The genus list of the family with id=#{family_id_list[i]} was successfully processed!"
		sleep 1.0 + rand
	end
end	