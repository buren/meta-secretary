MetaSecretary::Application.routes.draw do
  resources :deployments

  post 'new_deployment', to: 'deployments#create_remote_deployment'

  get 'latest_by_app_server', to: 'deployments#latest_by_app_server'

  get 'diff',       to: 'deployments#diff'
  get 'diff_route', to: 'deployments#diff_route'

  get 'dashboard/home'

  get 'charts/deploys_by_week'
  get 'charts/deploys_by_day'
  get 'charts/deploys_by_hour'
  get 'charts/deploys_by_application'
  get 'charts/last_year_commit_stats'

  get 'github/issue_summary'
  get 'github/repositories_summary'
  get 'github/members_summary'
  get 'github/latest_deployments'
  get 'github/milestones'
  get 'github/commits_before'
  get 'github/commits'

  root 'dashboard#home'
end
