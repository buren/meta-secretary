class ReactDeploysController < ApplicationController
  def index
    deploys = deploys_by_app { |deploys_by_app| deploys_by_app.deploys_by_day.to_a }
    @react_deploys_props = {
      name: 'Friend',
      deploys: deploys
    }
  end

  private

  def deploys_by_app(&block)
    Deployment.unique_applications.map do |app_name|
      {
        name: app_name,
        data: yield(Deployment.where(application: app_name))
      }
    end
  end
end
