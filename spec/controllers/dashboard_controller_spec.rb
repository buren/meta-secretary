require 'spec_helper'

describe DashboardController do

  # This should return the minimal set of attributes required to create a valid deployment
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in GithubController.
  def valid_session
    {}
  end

  describe 'GET home', no_travis: true do
    it 'renders home template' do
      get :home
      response.should render_template('home')
    end
  end

  describe "GET deploys_by_week", no_travis: true do
    it "returns 200 response and returns JSON" do
      get :home
      expect(response.status).to eq(200)
    end
  end

end
