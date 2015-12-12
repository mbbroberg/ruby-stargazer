require 'github_api'
load "pw.config"

# Authentication
org = 'intelsdi-x'
github = Github.new login:'mjbrender', password: PW

begin
  # get all repositories visible under intelsdi-x
  # note that it includes public and private
  intelsdi_repos = github.repos.list org: org, auto_pagination: true

  # hash that will contain all unique users
  all_users = {}

  # for all repos
  # if key doesn't exist
  # put username as key
  # print size of table

  intelsdi.each do |repo|
      # Make the call to get all users from the repo
      puts "Looking up all repositories under " + org + ". This can take a little while..."
      all_stars = github.activity.starring.list user: org, repo: repo.name, auto_pagination: true

      all_stars.each do |user|
          key = user.login
          if all_users.value?(key) == false
              all_users[key] = 1
              #exit()
          end
          puts all_users.length
      end
  end

  puts all_users.length()


rescue Github::Error::GithubError => e
  puts e.message

  if e.is_a? Github::Error::ServiceError
    puts "You had a service issue with talking to GitHub."
  elsif e.is_a? Github::Error::ClientError
    puts "You messed up your call. Check parameters."
  end
end

# user object returns:
#<Hashie::Mash avatar_url="https://avatars.githubusercontent.com/u/21?v=3" events_url="https://api.github.com/users/technoweenie/events{/privacy}" followers_url="https://api.github.com/users/technoweenie/followers" following_url="https://api.github.com/users/technoweenie/following{/other_user}" gists_url="https://api.github.com/users/technoweenie/gists{/gist_id}" gravatar_id="" html_url="https://github.com/technoweenie" id=21 login="technoweenie" organizations_url="https://api.github.com/users/technoweenie/orgs" received_events_url="https://api.github.com/users/technoweenie/received_events" repos_url="https://api.github.com/users/technoweenie/repos" site_admin=true starred_url="https://api.github.com/users/technoweenie/starred{/owner}{/repo}" subscriptions_url="https://api.github.com/users/technoweenie/subscriptions" type="User" url="https://api.github.com/users/technoweenie">