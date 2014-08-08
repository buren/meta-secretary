class ChartsController < ApplicationController

  def deploys_by_week
    app_names = Deployment.unique_applications
    deps = Array.new
    app_names.each do |app_name|
      deps << {
        name: app_name,
        data: Deployment.where(application: app_name).deploys_by_week
      }
    end
    render json: deps
  end

  def deploys_by_day
    uniq_apps = Deployment.unique_applications
    deploys = uniq_apps.map do |app_name|
      {
        name: app_name,
        data: Deployment.where(application: app_name).deploys_by_day
      }
    end
    render json: deploys
  end

  def deploys_by_hour
    uniq_apps = Deployment.unique_applications
    deploys = uniq_apps.map do |app_name|
      {
        name: app_name,
        data: Deployment.where(application: app_name).deploys_per_hour
      }
    end
    render json: deploys
  end

  def deploys_by_application
    render json: Deployment.deploys_by_application
  end

  def last_year_commit_stats
    render json: GithubAPI.new.last_year_commit_stats
  end

end
