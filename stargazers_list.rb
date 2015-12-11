# Written by @lynxbat, adapted by @mjbrender

require "octokit"
load "pw.config"

# You can pipe output to a CSV with "ruby stars.rb > out.csv"
# It will print progress to STDERR on screen

orgs = {}
# Octokit.auto_paginate = true
client = Octokit::Client.new(:login=>"mjbrender", :password=>PW)

sg = client.stargazers("intelsdi-x/snap")
sg.each do | gazer |
	c = client.user(gazer.login).company
	if c then
		orgs[c.strip] ||= 0
		orgs[c.strip] += 1
		STDERR.print c + ", "
	end
	oarr = client.organizations(gazer.login)
	oarr.each do |o|
		og = client.organization(o.login)
		if og.name != nil then
			orgs[og.name.strip] ||= 0
			orgs[og.name.strip] += 1
			STDERR.print og.name + ", "
		elsif og.login != nil
			orgs[og.login.strip] ||= 0
			orgs[og.login.strip] += 1
			STDERR.print og.login + ", "
		end
	end
end

orgs.each do |k,v|
	puts k + "," + v.to_s
end
