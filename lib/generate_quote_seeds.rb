require 'csv'

CSV.foreach("../../data/daily_sql_dump_2.csv") do |row|
	
	symbol, time, open, high, low, close, volume, period, date = row

	security_id = case symbol
	when "AAPL"
		1
	when "AMZN"
		2
	when "CERN"
		3
	when "DIS"
		4
	else
		5
	end

	puts "\t{"
	puts "\t\tsecurity_id: #{security_id},"
	puts "\t\ttime: \"#{time}\","
	puts "\t\topen: #{open},"
	puts "\t\thigh: #{high},"
	puts "\t\tlow: #{low},"
	puts "\t\tclose: #{close},"
	puts "\t\tvolume: #{volume},"
	puts "\t\tperiod: \"#{period}\","
	puts "\t\tdate: \"#{date}\""
	puts "\t},"
end