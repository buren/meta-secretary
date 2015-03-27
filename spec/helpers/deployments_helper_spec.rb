require 'spec_helper'

describe DeploymentsHelper do

  it 'should return deployed app count as a sentence' do
    deployed_app_count_sentence.should eq("0 apps, deployed 0 times")
    Deployment.create(commit_sha: '0123456789', application: 'app_name', repository_name: 'repo_name', server: 'server')
    deployed_app_count_sentence.should eq("1 deployed app")
    Deployment.create(commit_sha: '0123456789232', application: 'app_name1', repository_name: 'repo_name', server: 'server')
    deployed_app_count_sentence.should eq("2 deployed apps")
  end

  it 'should return deployed app count' do
    app_length = Deployment.deployed_application_names.length
    deployed_apps_count.should eq(app_length)
  end

  it 'should return app and server' do
    app_name = 'app_name'
    server   = 'localghost'
    deployment = Deployment.create(commit_sha: '0123456789', application: app_name, repository_name: 'repo_name', server: 'server')
    deployment.server = server
    app_and_server_for(deployment).should eq("#{app_name}<br>(#{server})")
  end

  it 'should return deploy diff form' do
    app_name = 'app_name'
    deployment = Deployment.create(commit_sha: '0123456789', application: app_name, repository_name: 'repo_name', server: 'server')
    rendered_form = diff_deploy_app_form(app_name)
    expect(rendered_form.starts_with?('<form')).to be_true
    expect(rendered_form.ends_with?('form>')).to be_true
  end

end
