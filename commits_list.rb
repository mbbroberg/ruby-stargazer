# Written by @lynxbat, adapted by @mjbrender

require "octokit"
load "pw.config"

# You can pipe output to a CSV with "ruby stars.rb > out.csv"
# It will print progress to STDERR on screen

commit_tally = {}
commit_tally_sum = 0

committer_orgs = {}

Octokit.auto_paginate = true ## Need this to get over 30 responses
client = Octokit::Client.new(:login=>"mjbrender", :password=>PW)
commits = client.commits("intelsdi-x/snap")

commits.each do | c |
	if c then
		## store the committer's organization
		author = c.author.login.strip
		author_auth = Octokit.user author
		author_org = author_auth[:company]
		committer_orgs[author] = author

	  ## tally total commits per user
		commit_tally[author] ||= 0
		commit_tally[author] += 1

		## print out what we've done so far
		STDERR.print author + " from " + author_org + ", "
	end
	exit()
	oarr = client.organizations(gazer.login)
	oarr.each do |o|
		og = client.organization(o.login)
		if og.name != nil then
			commit_tally[og.name.strip] ||= 0
			commit_tally[og.name.strip] += 1
			STDERR.print og.name + ", "
		elsif og.login != nil
			commit_tally[og.login.strip] ||= 0
			commit_tally[og.login.strip] += 1
			STDERR.print og.login + ", "
		end
	end
end

commit_tally.each do |k,v|
	puts k + "," + v.to_s
end

puts "Total commits:, " + star_sum.to_s
