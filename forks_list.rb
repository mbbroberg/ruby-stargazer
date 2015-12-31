# Written by @lynxbat, adapted by @mjbrender

require "octokit"
load "pw.config"

# You can pipe output to a CSV with "ruby stars.rb > out.csv"
# It will print progress to STDERR on screen

# forker is a nested hash
forker = Hash.new do |hsh, key|
	hsh[key] = {
		id: key,
		org: ""
	}
end

fork_org_tally = {}
fork_org_tally_sum = 0

Octokit.auto_paginate = true ## Need this to get over 30 responses
client = Octokit::Client.new \
	:login		=> "mjbrender",
	:password	=> PW

forks = client.forks("intelsdi-x/snap")

forks.each do | f |
	if f then
		x = defined? f[:owner][:login]
		y = defined? f[:owner][:organizations_url]
		if x != nil
			author = f[:owner][:login]
			author.strip!
			company = client.user(author).company
		elsif y != nil
			author = f[:owner][:organizations_url]
			company = client.user(author).company
		else
			puts "Something went wrong"
			puts f.inspect
			author = "Error on call"
			company = "Error on call"
		end

		## prevent trying to strip from an empty string
		if company != nil
			author_org = company.strip
		else
			author_org = "None Listed"
		end

		## org normalizing can happen here
		case author_org
		when "Intel Corporation"
			author_org = "Intel"
		when "Intel Technology Poland"
			author_org = "Intel"

		end
		## end normalizing

		forker[author][:org] = author_org

		## print out what we've done so far
		#STDERR.print author + " from " + author_org + ", "

		## then tally from an org perspective
		if fork_org_tally[author_org] == nil then
			fork_org_tally[author_org] ||= 0
			fork_org_tally[author_org] += 1
			#STDERR.print "First time seeing " + author_org + ".\n"
		else
			fork_org_tally[author_org] += 1
			#STDERR.print "giving " + author_org + " forks totalling " + fork_org_tally[author_org].to_s + ".\n"
		end
	end
end

######################
## Report print out ##
######################

## Setting up top row of a spreadsheet
puts "user,their org,org,forks by org"

forker.each do |key, hash|
	## user and their total and org
	puts hash[:id] + ", " + hash[:org]
end
fork_org_tally.each do |org|
	puts org[0] + ", " + org[1].to_s
end
puts "Total forks:, " + forks.length.to_s
