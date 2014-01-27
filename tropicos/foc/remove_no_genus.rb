# remove redundant genus name lines, as tribe. subfam.

require 'fileutils'

File.open("genus_list_removed.txt", "w") do |out_file|
  File.foreach("genus_list.txt") do |line|
    out_file.puts line unless line =~ (/\ss[e,u][b,c,r]/)
  end
end

FileUtils.mv("family_list_removed.txt", "family_list.txt")