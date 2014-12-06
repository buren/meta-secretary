class Deployment < ActiveRecord::Base
  validates_presence_of :commit_sha, :application, :repository_name, :server
  validates :commit_sha, length: { minimum: 10 }

  scope :latest,        ->(limit) { all.order(id: :desc).limit(limit) }
  scope :latest_by_app, ->(app)   { where(application: app).latest(1) }

  scope :deploys_in_commit, ->(commit_shas) { where(commit_sha: commit_shas) }

  def self.deployed_application_names
    all.map(&:application).uniq
  end

  def self.deployed_server_names
    all.map(&:server).uniq
  end

  def self.latest_by_app_server
    res = where(server: deployed_server_names).order(:application, created_at: :desc)
    ret = Array.new
    app_servers = Array.new
    res.each do |deploy|
      app_hash = {
        app:    deploy.application,
        server: deploy.server
      }
      ret << deploy unless app_servers.include?(app_hash)
      app_servers << app_hash
    end
    ret
  end

  def self.deploys_by_week
    group_by_week(:created_at).count
  end

  def self.deploys_by_day
    group_by_day_of_week(:created_at, format: '%a').count
  end

  def self.deploys_by_hour
    group_by_hour_of_day(:created_at, format: '%l %P').count
  end

  def self.deploys_by_application
    group(:application).count
  end

  def self.unique_applications
    uniq.pluck(:application)
  end

  def tag_or_commit_sha
    tag.blank? ? commit_sha : tag
  end

end
