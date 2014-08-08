require 'spec_helper'

describe ChartsController do
  describe 'routing' do

    it 'routes to #deploys_by_week' do
      get('/charts/deploys_by_week').should route_to('charts#deploys_by_week')
    end

    it 'routes to #deploys_by_day' do
      get('/charts/deploys_by_day').should route_to('charts#deploys_by_day')
    end

    it 'routes to #deploys_by_hour' do
      get('/charts/deploys_by_hour').should route_to('charts#deploys_by_hour')
    end

    it 'routes to #deploys_by_application' do
      get('/charts/deploys_by_application').should route_to('charts#deploys_by_application')
    end

    it 'routes to #last_year_commit_stats' do
      get('/charts/last_year_commit_stats').should route_to('charts#last_year_commit_stats')
    end

  end
end
