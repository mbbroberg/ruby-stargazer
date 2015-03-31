require 'github_api'
load "pw.config"

github = Github.new login:'mjbrender', password: PW
list = github.repos.list public: true, org: 'basho-labs', auto_pagination: true

list.each do |repo|
    puts repo.name
end


# for all repos 
# if key doesn't exist
# put username as value 
# print size of table 

