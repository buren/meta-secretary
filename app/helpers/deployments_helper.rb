module DeploymentsHelper

  def deployed_app_count_sentence
    apps_count = deployed_apps_count
    t('deploy.app_count_sentence', apps_count: apps_count, apps: t('common.app').pluralize(apps_count))
  end

  def deployed_apps_count
    Deployment.deployed_application_names.length
  end

  def app_and_server_for deployment
    res  = deployment.application
    res += '<br>'
    res += "(#{deployment.server})" unless deployment.server.blank?
    res.html_safe
  end

  def diff_deploy_app_form(app)
    form_tag(diff_path, method: :get, class: 'form-inline diff-choose-app') do
      select_tag :app, options_for_select(Deployment.deployed_application_names, app), class: 'form-control', onchange: 'this.form.submit()'
    end
  end

end
