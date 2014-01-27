

# Taxa = Struct.new(:familyid, :latinname, :namezh, :lowertaxa, :focvolume)

# def getfamilyid
# 	File.open("family_list.txt") do |file|
# 		taxon = []
# 		file.each do |line|
# 			familyid, latinname, namezh, lowertaxa, focvolume = line.chomp.split(/\s*\|\s*/)
# 		    taxon << Taxa.new(familyid, latinname, namezh, lowertaxa, focvolume)
# 		end
# 	end
# end

# puts getfamilyid
family_id_list = []
lowertaxa_list = []
File.foreach("family_list.txt") do |line|
	familyid, latinname, namezh, lowertaxa, focvolume = line.chomp.split(/\s*\|\s*/)
	family_id_list << familyid
	lowertaxa_list << lowertaxa
end

fam_num = family_id_list.length

# find records with more than 200 lower taxa number
for i in 0..fam_num
	puts family_id_list[i]+"<->"+lowertaxa_list[i]+"\r\n" if lowertaxa_list[i].to_i > 200
end






