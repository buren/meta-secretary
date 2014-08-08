class DashboardController < ApplicationController

  def home
    @github = GithubAPI.new
  end

end
