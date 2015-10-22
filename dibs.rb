require 'github_api'
load "pw.config"

# Authentication
github = Github.new login:'mjbrender', password: PW

# get all repositories visible under basho-labs
# note that it includes public and private
#labs_repos =  github.repos.list org: 'basho-labs', auto_pagination: true
#competition = github.issues.get 'basho-labs', 'the-basho-community', '75'
dibs = github.issues.get 'basho-labs', 'the-basho-community', '64'

dibs.each do |comment|
  if comment.find('#dibs') != nil
    github.issues.labels.add 'basho-labs', 'the-basho-community', '64', 'status/claimed'
  else
    puts "No dibs claimed yet"
  end
end
