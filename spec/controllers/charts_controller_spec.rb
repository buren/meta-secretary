require 'spec_helper'

describe ChartsController do

  before(:each) do
    Deployment.create(commit_sha: '0123456789', application: 'app_name', repository_name: 'repo_name')
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

  describe "GET deploys_by_week" do
    it "returns 200 response and returns JSON" do
      get :deploys_by_week
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json.class).to eq(Array)
    end
  end

  describe "GET deploys_by_day" do
    it "returns 200 response and returns JSON" do
      get :deploys_by_day
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json.class).to eq(Array)
    end
  end

  describe "GET deploys_by_hour" do
    it "returns 200 response and returns JSON" do
      get :deploys_by_hour
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json.class).to eq(Array)
    end
  end

  describe "GET deploys_by_application" do
    it "returns 200 response and returns JSON" do
      get :deploys_by_application
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json.class).to eq(Hash)
    end
  end

  describe "GET last_year_commit_stats", no_travis: true do
    it "returns 200 response and returns JSON" do
      get :last_year_commit_stats
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json).to_not be_nil
    end
  end

end
