class DashboardController < ApplicationController

  def home
    @github = GithubApi.new
  end

end
