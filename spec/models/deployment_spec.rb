require 'spec_helper'

describe Deployment do

  it 'should not have any changed db columns' do
    column_names = %w(id created_at updated_at commit_sha tag server application ip_address repository_name)

    expected = true
    Deployment.column_names.each do |col|
      unless column_names.include?(col)
        expected = false
      end
    end
    expected.should be_true
  end

  it 'should validate presence of commit_sha' do
    deployment = Deployment.new
    deployment.valid?
    deployment.errors.messages[:commit_sha].include?(PRESENCE_ERROR).should be_true
  end

  it 'should validate presence of server' do
    deployment = Deployment.new
    deployment.valid?
    deployment.errors.messages[:server].include?(PRESENCE_ERROR).should be_true
  end

  it 'should validate presence of application' do
    deployment = Deployment.new
    deployment.valid?
    deployment.errors.messages[:application].include?(PRESENCE_ERROR).should be_true
  end

  it 'should validate presence of application' do
    deployment = Deployment.new
    deployment.valid?
    deployment.errors.messages[:repository_name].include?(PRESENCE_ERROR).should be_true
  end

  it 'should return unique application names' do
    app_names = ['1', '1', '2', '3']
    app_names.each { |app_name| Deployment.create(commit_sha: 'shashasha1', application: app_name, repository_name: 'repo_name', server: 'asd') }
    Deployment.deployed_application_names.should eq app_names.uniq
  end

  it 'should validate length of commit_sha' do
    ten_characters = '0123456789'
    to_few_characters = '0'
    deployment = Deployment.new(commit_sha: to_few_characters, application: 'app', repository_name: 'repo_name')
    deployment.valid?
    deployment.errors.messages[:commit_sha].include?(MIN_LENGTH_10_ERROR).should be_true
    deployment = Deployment.new(commit_sha: to_few_characters, application: 'app', repository_name: 'repo_name')
    deployment.errors.messages[:commit_sha].should be_nil
  end

  it 'should create a new valid deployment' do
    d = Deployment.new(commit_sha: 'shashasha1', application: 'app_name', repository_name: 'repo_name', server: 'asd')
    d.valid?.should be_true
  end

  it 'should return latest deployments' do
    Deployment.latest(10).length.should eq(0)
    range = (0..5)
    range.each do |index|
      Deployment.create!(commit_sha: '0123456789', application: "app_name-#{index}", repository_name: 'repo_name', server: 'asd')
    end
    range.each do |index|
      deploys = Deployment.latest(index)
      deploys.length.should eq(index)
    end
    Deployment.latest(1000).length.should eq(Deployment.all.length)
  end

  it 'should return latest deployments per {app, server}' do
    Deployment.latest(10).length.should eq(0)
    range = (0..5)
    range.each do |index|
      Deployment.create!(commit_sha: '0123456789', application: "app_name_#{index}", repository_name: 'repo_name', server: 'localghost')
    end
    sleep 1 # is unfortunatly needed
    later_sha = '01234567890'
    range.each do |index|
      Deployment.create!(commit_sha: later_sha, application: "app_name_#{index}", repository_name: 'repo_name1', server: 'localghost')
    end
    range.each do |index|
      deploys = Deployment.latest(index)
      deploys.length.should eq(index)
    end
    latest = Deployment.latest_by_app_server
    latest.length.should eq(range.last + 1)
    latest.each { |deploy| deploy.commit_sha.should eq later_sha }
  end

  it 'should return deploys_by_day', no_travis: true do
    deploy = Deployment.create(commit_sha: '0123456789', application: "app_name", repository_name: 'repo_name', server: 'localghost')
    today = Date.today.strftime("%a")
    expected = {"Sun"=>0, "Mon"=>0, "Tue"=>0, "Wed"=>0, "Thu"=>0, "Fri"=>1, "Sat"=>0}.merge({today => 1})
    expect(Deployment.deploys_by_day).to eq(expected)
  end

  it 'should return deploys_by_week', no_travis: true do
    deploy = Deployment.create(commit_sha: '0123456789', application: "app_name", repository_name: 'repo_name', server: 'localghost')
    expect(Deployment.deploys_by_week).to be_a Hash
  end

  it 'should return deploys_by_hour' do
    deploy = Deployment.create(commit_sha: '0123456789', application: "app_name", repository_name: 'repo_name', server: 'localghost')
    expect(Deployment.deploys_by_hour).to be_a Hash
  end

end
