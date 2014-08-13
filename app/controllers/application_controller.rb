class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :requires_configuration?, :authenticate
  skip_before_action :requires_configuration? if Rails.env.test?

  helper_method :current_user

  def authenticate
    return true unless User.any? # If no users exist yet, don't authenticate

    if new_deploy_route?
      authenticate_deployer
    else
      authenticate_user
    end
  end

  def authenticate_deployer
    authenticate_or_request_with_http_token do |token, options|
      User.exists?(meta_access_token: token) or render(render_forbidden, status: :forbidden) and return
    end
  end

  def authenticate_user
    if user = authenticate_with_http_basic { |user, pass| User.authenticate(user, pass) }
      user
    else
      request_http_basic_authentication
    end
  end

  def current_user
    User.get
  end

  private

    def requires_configuration?
      redirect_to new_user_path and return if !User.any? && !new_meta_route?
    end

    def new_meta_route?
      params[:controller].eql?('users') && ['new', 'create'].include?(params[:action])
    end

    def new_deploy_route?
      params[:controller].eql?('deployments') && params[:action].eql?('create_remote_deployment')
    end

    def render_forbidden
      {
        json: {
          message: t('common.forbidden'),
          status:  403
        }
      }
    end

end
