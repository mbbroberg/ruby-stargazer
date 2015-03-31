require 'github_api'
load "pw.config"

github = Github.new login:'mjbrender', password: PW
list = github.repos.list org: 'basho-labs'

#.list user: 'basho-labs'

puts list


# for all repos 
# if key doesn't exist
# put username as value 
# print size of table 

