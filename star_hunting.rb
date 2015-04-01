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
    all_stars = github.activity.starring.list user: 'basho-labs', repo: repo.name, auto_pagination: true

    all_stars.each do |user|
        key = user.login
        if all_users.value?(key) == false
            all_users[key] = 1
            #exit()
        end
    end
end

puts all_users.length()

# user object returns: 
#<Hashie::Mash avatar_url="https://avatars.githubusercontent.com/u/21?v=3" events_url="https://api.github.com/users/technoweenie/events{/privacy}" followers_url="https://api.github.com/users/technoweenie/followers" following_url="https://api.github.com/users/technoweenie/following{/other_user}" gists_url="https://api.github.com/users/technoweenie/gists{/gist_id}" gravatar_id="" html_url="https://github.com/technoweenie" id=21 login="technoweenie" organizations_url="https://api.github.com/users/technoweenie/orgs" received_events_url="https://api.github.com/users/technoweenie/received_events" repos_url="https://api.github.com/users/technoweenie/repos" site_admin=true starred_url="https://api.github.com/users/technoweenie/starred{/owner}{/repo}" subscriptions_url="https://api.github.com/users/technoweenie/subscriptions" type="User" url="https://api.github.com/users/technoweenie">