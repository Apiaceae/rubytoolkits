

# Family start page for fern data on FOC
# http://www.efloras.org/browse.aspx?volume_id=2002

require "open-uri"
require "nokogiri"


# ^<p>[\s+]\n</p>
# ^<p>\n</p>
# arrf = IO.readlines("family.txt")
# arrg = IO.readlines("genus.txt")
# arrs = IO.readlines("species.txt")
# arrsd = IO.readlines("species_description.txt")
# puts arrf.length
# puts arrg.length
# puts arrs.length
# puts arrsd.length


# 处理物种描述信息页面
pages = Nokogiri::HTML(open("http://www.efloras.org/florataxon.aspx?flora_id=2&taxon_id=10291"), nil, "utf-8")
pages.encoding = "utf-8"

p_tag = []
pages.css('div#panelTaxonTreatment p').each do |row|
	p_tag << row.text.to_s.gsub(/^\R/, '') unless row.text.length < 1
end	
p_num = p_tag.length
puts p_num

for i in 0..(p_num-1)
	puts p_tag[i] if p_tag[i].strip.length > 2
end




# for i in 0..(p_num-1)
# 	if p_tag[i].to_s.gsub(/^\/<p>\s/, '').gsub(/<\/p>/, '')
# 		.strip.gsub(/<!-- Key -->/, '')
# 		.gsub(/[<span id=]+/, '')
# 		.gsub(/<span id="lblLowerTaxonList"><\/span>/, '').length > 2
# 		puts p_tag[i].to_s.gsub(/<p>/, '').gsub(/<\/p>/, '')
# 		.gsub(/<span\s+<\/span>/, '').strip
# 		.inspect
# 	end
# end



