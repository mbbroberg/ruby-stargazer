# Written by @lynxbat, adapted by @mjbrender

require "octokit"
load "pw.config"

# You can pipe output to a CSV with "ruby stars.rb > out.csv"
# It will print progress to STDERR on screen

# committers is a nested hash
committers = Hash.new do |hsh, key|
	hsh[key] = {
		id: key,
		org: "",
		tally: 0
	}
end

commit_tally = {}
commit_tally_sum = 0

Octokit.auto_paginate = true ## Need this to get over 30 responses
client = Octokit::Client.new \
	:login		=> USR,
	:password	=> PW

commits = client.commits("intelsdi-x/snap")

commits.each do | c |
	if c then
		x = defined? c[:committer][:login]
		y = defined? c[:committer][:email]
		if x != nil
			author = c[:committer][:login]
			author.strip!
			company = client.user(author).company
		elsif y != nil
			author = c[:committer][:email]
			author.strip!
			company = client.user(author).company
		else
			puts "Something went wrong"
			puts c.inspect
			author = "Error"
			company = "Error"
		end

		## prevent trying to strip from an empty string
		if company != nil
			author_org = company.strip
		else
			author_org = "Errors"
		end

		## org normalizing can happen here
		case author_org
		when "Intel Corporation"
			author_org = "Intel"
		end
		## end normalizing

		committers[author][:org] = author_org

	  ## tally total commits per user
		committers[author][:tally] ||= 0
		committers[author][:tally] += 1
		commit_tally_sum += 1

		## print out what we've done so far
		#STDERR.print author + " from " + author_org + ", "

		## then tally from an org perspective
		if commit_tally[author_org] == nil then
			commit_tally[author_org] ||= 0
			commit_tally[author_org] += 1
			#STDERR.print "First time seeing " + author_org + ".\n"
		else
			commit_tally[author_org] += 1
			#STDERR.print "giving " + author_org + " commits totalling " + commit_tally[author_org].to_s + ".\n"
		end
	end
end

######################
## Report print out ##
######################

## Setting up top row of a spreadsheet
print "user,commits by user,their org,org,commits by org"
puts ", Total commits:, " + commit_tally_sum.to_s

committers.each do |key, hash|
	count = 0
	## user and their total and org
	print hash[:id] + ", " + hash[:tally].to_s + ", " + hash[:org]

	## while count is less than the size of commit_tally, print next to line ^
	if commit_tally[count] then
		puts ", " + org[0] + ", " + org[1].to_s
	else
		puts ""
	end
	count += 1
end
