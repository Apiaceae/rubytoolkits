# get species name list

require "nokogiri"
require "open-uri"
require "useragens"


# FOC 网站主页面
BASE_URL = "http://www.efloras.org"

# 类群描述页面
TAXON_PAGE_URL = "/florataxon.aspx?flora_id=2&taxon_id="

# 下级类群列表页面
CHILD_LIST_URL = "/browse.aspx?flora_id=2&start_taxon_id="

# 页面数目索引
PAGE_INDEX_URL = "&page="

# 数据文件标题
content_title = "genusid | speciesid | latinname | namezh\r\n"


genus_id_list = []
lower_taxa_num = []

# 获取属名id, lowertaxa的数组
File.foreach("genus_list.txt") do |row|
  familyid, genusid, latinname, namezh, lowertaxa = row.chomp.split(/\s*\|\s*/)
  genus_id_list << genusid
  lower_taxa_num << lowertaxa
  genus_id_list.compact.uniq
end

gen_number = genus_id_list.length


# build species name list file
File.open("species_list.txt", "w") do |line|
  line.puts content_title
  for i in 1..gen_number
    # for recored more than one pages
    page_number = lower_taxa_num[i].to_i/200+1
    for j in 1..page_number
      pages = Nokogiri::HTML(open(BASE_URL+CHILD_LIST_URL+genus_id_list[i].to_s+PAGE_INDEX_URL+j.to_s), nil, "utf-8")
      agent = UserAgents.rand()
      pages.encoding = "utf-8"

      pages.css('tr.underline').each do |row|
        speciesid = row.search("td[1]").text
        latinname = row.search("td[2]").text
        namezh = row.search("td[3]").text

        line.puts "#{genus_id_list[i]} | #{speciesid} | #{latinname} | #{namezh}\r\n" if speciesid.to_i > 1
      end
    end
    puts "The species list of the genus with id=#{genus_id_list[i]} was successfully processed!"
    puts "\t...total #{i} genera processed..."
    sleep 1.0 + rand
  end
end
puts "\t... congratulations!!! species list successfully build!"

