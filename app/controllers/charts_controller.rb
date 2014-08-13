class ChartsController < ApplicationController

  def deploys_by_week
    deps = Array.new
    Deployment.unique_applications.each do |app_name|
      deps << {
        name: app_name,
        data: Deployment.where(application: app_name).deploys_by_week
      }
    end
    render json: deps
  end

  def deploys_by_day
    render json: deploys_by_app { |deploys_by_app| deploys_by_app.deploys_by_day }
  end

  def deploys_by_hour
    render json: deploys_by_app { |deploys_by_app| deploys_by_app.deploys_by_hour }
  end

  def deploys_by_application
    render json: Deployment.deploys_by_application
  end

  def last_year_commit_stats
    render json: github.last_year_commit_stats
  end

  private

    def github
      @github ||= GithubApi.new
    end

    def deploys_by_app(&block)
      Deployment.unique_applications.map do |app_name|
        {
          name: app_name,
          data: yield(Deployment.where(application: app_name))
        }
      end
    end

end
