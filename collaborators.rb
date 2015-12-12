require 'github_api'

begin
  collaborators = github_authed.repos.collaborators.all user:'intelsdi-x', repo:'snap'
  collaborators.each do |user|
    puts user.login
  end

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
