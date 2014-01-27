# remove lines no standard genus name

# no_gen_name_line = [subfam. sect. ser. subg. ]

require 'fileutils'

File.open("genus_list_removed.txt", "w") do |out_file|
  File.foreach("genus_list.txt") do |line|
    out_file.puts line unless line =~ (/\ss[e,u][b,c,r]/)
  end
end

FileUtils.mv("genus_list_removed.txt", "genus_list.txt")