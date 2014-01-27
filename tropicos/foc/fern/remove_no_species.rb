# remove lines no standard genus name

# no_gen_name_line = [subfam. sect. ser. subg. ]

require 'fileutils'

File.open("species_list_removed.txt", "w") do |out_file|
  File.foreach("species_list.txt") do |line|
    out_file.puts line unless line =~ (/\ss[e,u][b,c,r]/)
  end
end

FileUtils.mv("species_list_removed.txt", "species_list.txt")