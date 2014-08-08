require 'spec_helper'

describe GithubHelper do

  it 'should return github teams URL' do
    github_teams_url.should eq("#{MetaDefines::Github::BASE_URL}/orgs/#{MetaDefines::Github::ORG_NAME}/teams")
  end

end
