require 'spec_helper'

describe GithubController, no_travis: true do

  before(:each) do
    Deployment.create(commit_sha: '0123456789', application: 'app_name', repository_name: 'repo_name', server: 'test')
    controller.send(:extend, GithubControllerSetter)
    controller.send(:set_github_mock, GithubApiMock.new)
  end

  # This should return the minimal set of attributes required to create a valid deployment
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in GithubController.
  def valid_session
    {}
  end

  describe "GET issue_summary" do
    it "returns 200 response and returns JSON" do
      get :issue_summary
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["repositories"]).to_not be_nil
    end
  end

  describe "GET latest_deployments" do
    it "returns 200 response and returns JSON" do
      get :latest_deployments
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["deploys"]).to_not be_nil
    end
  end

  describe "GET repositories_summary" do
    it "returns 200 response and returns JSON" do
      get :repositories_summary
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["public_repo_count"]).to_not  be_nil
      expect(json["private_repo_count"]).to_not be_nil
      expect(json["total_repo_count"]).to_not   be_nil
      expect(json["repositories"]).to_not       be_nil
      expect(json["organization_link"]).to_not  be_nil
    end
  end

  describe "GET members_summary" do
    it "returns 200 response and returns JSON" do
      get :members_summary
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["members"]).to_not      be_nil
      expect(json["member_count"]).to_not be_nil
      expect(json["teams"]).to_not        be_nil
      expect(json["team_count"]).to_not   be_nil
    end
  end

  describe "GET milestones" do
    it "returns 200 response and returns JSON" do
      get :milestones
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["repo_milestones"]).to_not be_nil
    end
  end

  describe "GET commits_before" do
    it "returns 500 response and returns JSON with INVALID params" do
      expect { get :commits_before, { repo: '', sha: '' } }.to raise_error
    end

    it "returns 200 response and returns JSON with VALID params" do
      get :commits_before, { repo: 'mock-repo', sha: '9ea6a6dd5439843ad238ca761d0df102bf4dda93' }
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["commits"]).to_not be_nil
    end
  end

  describe "GET commits" do
    it "returns 200 response on empty repo and sha param" do
      get :commits
      expect(response.status).to eq(200)
    end

    it "returns 200 response on valid repo and sha param" do
      get :commits, { repo: 'mock-repo', sha: '9ea6a6dd5439843ad238ca761d0df102bf4dda93' }
      expect(response.status).to eq(200)
    end
  end

end
