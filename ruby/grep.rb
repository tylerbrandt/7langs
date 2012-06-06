(pattern,filename) = ARGV

File.open(filename, 'r') do |f|
	f.each { |line| puts line if line =~ /#{pattern}/ }
end