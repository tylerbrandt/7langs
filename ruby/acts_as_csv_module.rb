require 'forwardable'

module ActsAsCsv
	include Enumerable
	extend Forwardable
	def_delegators :@csv_contents, :each

	def self.included(base)
	    base.extend ClassMethods
	end
	
	module ClassMethods 
		def acts_as_csv
      		include InstanceMethods
		end
	end
	
	module InstanceMethods 
		def read
			@csv_contents = []
			filename = self.class.to_s.downcase + '.txt' 
			file = File.new(filename)
			@headers = file.gets.chomp.split(/,\s*/)
			file.each do |row|
				@csv_contents << CsvRow.new(self, row.chomp.split(/,\s*/))
			end
		end
		
		attr_accessor :headers, :csv_contents 
		
		def initialize
			read
		end
	end
end

class CsvRow
	def initialize(csv,row)
		@csv = csv
		@row = row
	end

	def method_missing name, *args
		header_idx = @csv.headers.index(name.to_s)
		if header_idx
			@row[header_idx]
		else
			super
		end
	end
end

class RubyCsv # no inheritance! You can mix it in 
	include ActsAsCsv
	acts_as_csv
end

csv = RubyCsv.new
csv.each {|row| puts row.one}