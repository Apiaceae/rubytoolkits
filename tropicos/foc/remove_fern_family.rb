# remove fern family lines

require 'fileutils'

File.open("family_list_removed.txt", "w") do |out_file|
  File.foreach("family_list.txt") do |line|
    out_file.puts line unless line =~ (/\FOC Vol.\s+2-3/)
  end
end

FileUtils.mv("family_list_removed.txt", "family_list.txt")