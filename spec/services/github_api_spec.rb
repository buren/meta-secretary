require 'spec_helper'

describe GithubApi, no_travis: true do

  before (:each) do
    @github      = GithubApiMock.new(owner: 'codeforamerica', access_token: ENV['SECRETARY_GITHUB_ACCESS_TOKEN'])
    @github_user = GithubApiMock.new(owner: 'buren')
  end

  it 'should return public repo count' do
    @github.public_repo_count.should be_a Integer
  end

  it 'should return private repo count' do
    @github.private_repo_count.should be_a Integer
  end

  it 'should return total repo count' do
    @github.total_repo_count.should be_a Integer
  end

  it 'should return a list of repositories' do
    @github.repositories.should be_a Array
  end

  it 'should return a list of milestones' do
    @github.repositories.should be_a Array
  end

  it 'should return a list of organization members' do
    @github.organization.members.should be_a Array
  end

  it 'should return a list of organization teams' do
    @github.organization.teams.should be_a Array
  end

  it 'should return a list of repository issues' do
    issues = @github.issues_for 'buren/git-story'
    issues[:repository_name].should eq('git-story')
    issues[:open].should       be_a Array
    issues[:open_count].should be_a Integer
  end

  it 'should return commits for repository' do
    issues = @github.commits_for('buren/git-story').first
    issues[:sha].should be_a String
    issues[:commit][:author][:name].should eq('Jacob Burenstam')
  end

  it 'should return commit for repository' do
    issues = @github.commits_for('buren/git-story', '9ea6a6dd5439843ad238ca761d0df102bf4dda93')
    issues[:sha].should be_a String
    issues[:commit][:author][:name].should eq('Jacob Burenstam')
  end

  it 'should find repo by name' do
    repo = @github.find_repo_by_name('mock-repo')
    repo[:name].should eq('mock-repo')
  end

  it 'should return the organization url' do
    github = @github
    github.org_url.should eq 'https://example.com/mock-url'
  end

  it 'should return github_teams_url' do
    @github.organization.github_teams_url.should include('/orgs/')
    @github.organization.github_teams_url.should include('/teams')
  end

  it 'should return github_commit_url' do
    github = GithubApi.new(owner: 'codeforamerica', base_url: 'https://github.com')
    github.github_commit_url('codeforamerica.org', 'ad797b1959387e7d1fb7c53c27acaa284ad2ef09').should eq('https://github.com/codeforamerica/codeforamerica.org/commit/ad797b1959387e7d1fb7c53c27acaa284ad2ef09')
  end

  it 'should return github_commit_url' do
    github = GithubApi.new(owner: 'codeforamerica', base_url: 'https://github.com')
    github.github_diff_url('codeforamerica.org', 'ad797b1959387e7d1fb7c53c27acaa284ad2ef09', '469a9c072f321d10427ec5da188ec7e4dfe520bc').should eq('https://github.com/codeforamerica/codeforamerica.org/compare/ad797b1959387e7d1fb7c53c27acaa284ad2ef09...469a9c072f321d10427ec5da188ec7e4dfe520bc')
  end

  it 'should calculate completion_ratio' do
    ratio = @github.send(:completion_ratio, 0, 0)
    ratio.should eq 0
    ratio = @github.send(:completion_ratio, 0.0, 0.0)
    ratio.should eq 0
    ratio = @github.send(:completion_ratio, 0, 1)
    ratio.should eq 100
    ratio = @github.send(:completion_ratio, 2, 2)
    ratio.should eq 50
    ratio = @github.send(:completion_ratio, 6, 2)
    ratio.should eq 25
    ratio = @github.send(:completion_ratio, 6.0, 6.0)
    ratio.should eq 50
  end

  it 'should shorten full repository name' do
    name = @github.send(:shorten_repo_name, 'buren/git-story') # Call private method
    name.should eq 'git-story'
    name = @github.send(:shorten_repo_name, 'rails/rails')
    name.should eq 'rails'
    name = @github.send(:shorten_repo_name, '/rails/rails')
    name.should eq 'rails/rails'
    name = @github.send(:shorten_repo_name, 'codeforamerica/codeforamerica.org')
    name.should eq 'codeforamerica.org'
    name = @github.send(:shorten_repo_name, 'octokit.rb')
    name.should eq 'octokit.rb'
    name = @github.send(:shorten_repo_name, 'git-story')
    name.should eq 'git-story'
    name = @github.send(:shorten_repo_name, 'buren/buren/git-story')
    name.should eq 'buren/git-story'
  end

  it 'should extract repository name from GitHub milestone URL' do
    github = @github
    name   = github.send(:repo_name_from_milestone_url, 'https://github.com/codeforamerica/codeforamerica.org/milestones/1') # Call private method
    name.should eq 'codeforamerica.org'
    name =   github.send(:repo_name_from_milestone_url, 'codeforamerica/codeforamerica.org/milestones/1')
    name.should eq 'codeforamerica.org'
  end

  it 'should return last year commit stats for repository' do
    github = @github
    stats  = github.send(:last_year_commit_stat, 'codeforamerica.org')
    stats[:name].should eq 'codeforamerica.org'
    stats[:data].should be_a Hash
  end

  it 'should return previous commits from commit sha' do
    github = @github
    stats  = github.commits_before('codeforamerica.org', '93778b3e8f7c4bb9a45375a689149bd4e36dd478')
    stats.should be_a Array
    stats.length.should eq 30
    stats.first[:sha].should eq '9ea6a6dd5439843ad238ca761d0df102bf4dda93'
  end

  describe 'NilOrganization should return' do

    it 'repositiories' do
      @github_user.organization.repositories.class.should eq Array
    end

    it 'teams' do
      @github_user.organization.teams.class.should eq Array
    end

    it 'members' do
      @github_user.organization.members.class.should eq Array
    end

  end

end
