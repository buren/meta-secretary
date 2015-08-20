class GithubController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :github

  LATEST_DEPLOY_LIMIT = 3

  def stats
  end

  def issue_summary
    repos = github.repositories.map { |repo| github.issues_for(repo.full_name) }
    repos = repos.reject { |repo| repo[:open_count].zero? }
    render json: { repositories: repos }
  end

  def latest_deployments
    latest_deploys = Deployment.latest_by_app_server.map do |deployment|
      {
        application:     deployment.application,
        repository_name: deployment.repository_name,
        server:          deployment.server,
        commit_sha:      deployment.tag_or_commit_sha,
        label:           deployment.tag_or_commit_sha[0..10],
        html_url:        github.github_commit_url(deployment.repository_name, deployment.commit_sha)
      }
    end
    render json: { deploys: latest_deploys }
  end

  def repositories_summary
    repos = Array.new
    github.repositories.each do |repo|
      repos << {
        name:     repo.name,
        html_url: repo.html_url,
        language: repo.language
      }
    end
    repositories_summary = {
      public_repo_count:  github.public_repo_count,
      private_repo_count: github.private_repo_count,
      total_repo_count:   github.total_repo_count,
      repositories:       repos,
      organization_link:  github.org_url
    }
    render json: repositories_summary
  end

  def members_summary
    members = Array.new
    github.organization.members.each do |member|
      members << {
        login:    member.login,
        html_url: member.html_url
      }
    end
    teams = github.organization.teams.map { |team| { name: team.name } }
    members_summary = {
      members:      members,
      member_count: members.length,
      teams:        teams,
      team_count:   teams.length
    }
    render json: members_summary
  end

  def milestones
    repo_milestones = github.repositories.map do |repo|
      {
        repository_name: repo.name,
        milestones:      github.milestones(repo.full_name)
      }
    end.reject { |e| e[:milestones].blank? }
    render json: { repo_milestones: repo_milestones }
  end

  def commits_before
    # TODO: Extract to GithubApi
    index = -1
    commits_before_reslut = github.commits_before(params[:repo], params[:sha])
    commit_shas = commits_before_reslut.map(&:sha)
    @deploys_in_commits = Deployment.deploys_in_commit(commit_shas)
    commits = commits_before_reslut.map do |commit|
      index += 1
      build_commit_hash_for @deploys_in_commits, commit, index
    end
    render json: { commits: commits }
  end

  def commits
    @repo_name  = params[:repo]
    @commit_sha = params[:sha]
  end

  private
    def github
      @github ||= GithubApi.new
    end

    def build_commit_hash_for(deploys, commit, index)
      max_title_chars = 45
      commit_message = commit.commit.message
      message_body   = commit_message.length > max_title_chars ? commit_message.gsub(/\n/, '<br>').html_safe : ''
      {
        repository_name: params[:repo],
        commit_sha:      commit.sha,
        author:          commit.commit.author.name,
        time_ago:        t('common.time_ago', time: time_ago_in_words(commit.commit.author.date)),
        message_title:   commit_message.truncate(max_title_chars),
        message_body:    message_body,
        inverted_class:  (index.even? ? '' : MetaDefines::View::TIMELINE_INVERTED_LI),
        deployed_to:     deploys.map(&:server).uniq.join(', ')
      }
    end

end
