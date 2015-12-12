require 'github_api'
load "pw.config"

begin
  target_org = 'intelsdi-x'

  contributors = {}
  contr_orgs = {}

  stargazers_count = -1
  stargazers = {}
  star_orgs = {}

  prs = {}
  commits = {}

  visitors = {} # Not possible via API
  clones = {}   # Not possible via API

  ######### Authenticate with an account #########
  # With the intent of getting access to ... is this needed?
  authed_github = Github.new login: 'mjbrender', password: PW

  ######### Get our target repos #########
  repos_raw = authed_github.repositories.list
  puts repos_raw
  exit()
  repos_raw.each do |repo|
    puts "stars on " + repo.name + ": " + repo.stargazers_count.to_s ##

  end
  ######### Stargazer analysis #########
  

  ######### Commits #########
  #repos_raw = Github::Client::Repos.actions
  #  .commits

rescue Github::Error::GithubError => e
  puts e.message

  if e.is_a? Github::Error::ServiceError
    puts "You had a service issue with talking to GitHub."
  elsif e.is_a? Github::Error::ClientError
    puts "You messed up your call. Check parameters."
  end
end
