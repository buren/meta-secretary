module GithubHelper
  GITHUB_URL = MetaDefines::Github::BASE_URL
  GITHUB_ORG = MetaDefines::Github::ORG_NAME

  def github_teams_url
    "#{GITHUB_URL}/orgs/#{GITHUB_ORG}/teams"
  end
  
end
