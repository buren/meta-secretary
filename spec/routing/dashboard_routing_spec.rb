require 'spec_helper'

describe DashboardController do
  describe 'routing' do

    it 'routes to #home' do
      get('/dashboard/home').should route_to('dashboard#home')
    end

    it 'root routes to #home' do
      get('/').should route_to('dashboard#home')
    end

  end
end
