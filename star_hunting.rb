require 'github_api'
load "pw.config"

# Authentication 
github = Github.new login:'mjbrender', password: PW

# get all repositories visible under basho-labs
# note that it includes public and private
list = github.repos.list org: 'basho-labs', auto_pagination: true

# hash that will contain all unique users 
all_users = {}

# for all repos 
# if key doesn't exist
# put username as value 
# print size of table 

list.each do |repo|
    # Make the call to get all users from the repo
    all_stars = github.activity.starring.list user: 'basho-labs', repo: repo.name #, auto_pagination: true

    all_stars.each do |user|
        puts user.login
    end
end
