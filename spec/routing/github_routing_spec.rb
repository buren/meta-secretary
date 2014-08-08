require 'spec_helper'

describe GithubController do
  describe 'routing' do

    it 'routes to #issue_summary' do
      get('/github/issue_summary').should route_to('github#issue_summary')
    end

    it 'routes to #repositories_summary' do
      get('/github/repositories_summary').should route_to('github#repositories_summary')
    end

    it 'routes to #members_summary' do
      get('/github/members_summary').should route_to('github#members_summary')
    end

    it 'routes to #latest_deployments' do
      get('/github/latest_deployments').should route_to('github#latest_deployments')
    end

    it 'routes to #milestones' do
      get('/github/milestones').should route_to('github#milestones')
    end

    it 'routes to #commits_before' do
      get('/github/commits_before').should route_to('github#commits_before')
    end

    it 'routes to #commits' do
      get('/github/commits').should route_to('github#commits')
    end

  end
end
