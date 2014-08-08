class DeploymentsController < ApplicationController
  before_action :set_deployment, only: [:show, :edit, :update, :destroy]

  protect_from_forgery except: :create_remote_deployment # Allow submission of deployments without CSRF token

  def latest_by_app_server
    render json: Deployment.latest_by_app_server
  end

  # GET /deployments
  def index
    @deployments = Deployment.all.order(created_at: :asc)
    @github = GithubAPI.new
  end

  # GET /deployments/1
  def show
  end

  # GET /deployments/new
  def new
    @deployment = Deployment.new
  end

  # GET /deployments/1/edit
  def edit
  end

  # POST /deployments
  def create
    @deployment = Deployment.new(deployment_params)

    if @deployment.save
      redirect_to @deployment, notice: t('deploy.success')
    else
      render action: 'new'
    end
  end

  # POST /new_deployment
  def create_remote_deployment
    @deployment = Deployment.new(deployment_params)

    if @deployment.save
      render json: { status: 200, notice: t('deploy.success') }
    else
      render json: { status: 500, notice: t('deploy.fail') }, status: 500
    end
  end

  # PATCH/PUT /deployments/1
  def update
    if @deployment.update(deployment_params)
      redirect_to @deployment, notice: t('deploy.updated')
    else
      render action: 'edit'
    end
  end

  # DELETE /deployments/1
  def destroy
    @deployment.destroy
    redirect_to deployments_url, notice: t('deploy.destoyed')
  end

  # GET /diff
  def diff
    @deployed_servers = Deployment.where(application: params[:app]).map(&:server).uniq
    redirect_to root_path, flash: { error: t('deploy.no_such_server') } if @deployed_servers.blank?
  end

  # GET /diff_route
  def diff_route
    app_deploys    = Deployment.where(application: params[:app])
    diff_server    = params[:diff_server]
    deploy_history = params[:deploy_history]

    base_deployments = app_deploys.where(server: params[:base_server])
    repo_name   = base_deployments.last.repository_name
    commit_tail = base_deployments.last.tag_or_commit_sha
    commit_head = ''

    if !diff_server.blank?
      commit_head = app_deploys.where(server: diff_server).last.tag_or_commit_sha
    elsif !deploy_history.blank?
      commit_head = commit_tail
      commit_tail = base_deployments.last(deploy_history.to_i + 1).first.tag_or_commit_sha
    else
      flash[:error] = t('deploy.diff.no_comparison_value_error')
      redirect_to diff_path(app: application) and return
    end
    github_url = GithubAPI.new.github_diff_url(repo_name, commit_tail, commit_head)
    redirect_to github_url and return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deployment
      @deployment = Deployment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def deployment_params
      params.require(:deployment).permit(:commit_sha, :tag, :server, :application, :ip_address, :repository_name)
    end
end
