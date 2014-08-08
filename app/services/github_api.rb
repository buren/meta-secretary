class GithubAPI
  DEFAULT_OPTIONS = {
    access_token: MetaDefines::Github::ACCESS_TOKEN,
    organization: MetaDefines::Github::ORG_NAME,
    base_url:     MetaDefines::Github::BASE_URL
  }

  def initialize options = {}
    @options = (DEFAULT_OPTIONS).merge(options)
    set_github_client_and_organization
  end

  # Returns total number of public repositories
  def public_repo_count
    @org.public_repos
  end

  # Returns total number of private repositories
  def private_repo_count
    @org.total_private_repos
  end

  def total_repo_count
    repositories.length
  end

  # Returns a list of repositories
  def repositories
    @repositories ||= @client.organization_repositories(@options[:organization])
  end

  def find_repo_by_name name
    repositories.reject { |repo| repo unless repo.name.eql?(name) }.first
  end

  def milestones repository
    @client.list_milestones(repository).map do |milestone|
      {
        repository_name:  repo_name_from_milestone_url(milestone.url),
        title:            milestone.title,
        description:      milestone.description,
        open_issues:      milestone.open_issues,
        closed_issues:    milestone.closed_issues,
        state:            milestone.state,
        completion_ratio: completion_ratio(milestone.open_issues, milestone.closed_issues).round(0),
        html_url:         "#{@options[:base_url]}/#{repository}/issues?milestone=#{milestone.number}&state=open"
      }
    end
  end

  def members
    @client.organization_members(@options[:organization])
  end

  def teams
    @client.organization_teams(@options[:organization])
  end

  def issues_for full_repo_name
    open_issues = @client.issues(full_repo_name)
    {
      repository_name: shorten_repo_name(full_repo_name),
      open:            open_issues,
      open_count:      open_issues.length
    }
  end

  def commits_for repo_name, commit_sha = nil
    if commit_sha.nil?
      @client.commits(repo_name)
    else
      @client.commit(repo_name, commit_sha)
    end
  end

  def commits_before repo_name, commit_sha
    raise 'Required argument repo_name not present'  if repo_name.blank?
    raise 'Required argument commit_sha not present' if commit_sha.blank?
    @client.commits_before(full_repo_name(repo_name), Date.tomorrow.to_s, commit_sha)
  end

  def last_year_commit_stats
    repositories.map(&:name).map &method(:last_year_commit_stat)
  end

  def org_url
    @org.html_url
  end

  def github_teams_url
    "#{@options[:base_url]}/orgs/#{@options[:organization]}/teams"
  end

  def github_commit_url repo_name, commit_sha
    "#{@options[:base_url]}/#{@options[:organization]}/#{repo_name}/commit/#{commit_sha}"
  end

  def github_diff_url repo_name, commit_tail, commit_head
    "#{@options[:base_url]}/#{@options[:organization]}/#{repo_name}/compare/#{commit_tail}...#{commit_head}"
  end

  private
    def set_github_client_and_organization
      @client ||= Octokit::Client.new(access_token: @options[:access_token])
      @org    ||= @client.organization(@options[:organization])
    end

    def completion_ratio open, closed
      total = (open + closed)
      return 0   if total.zero?
      return 100 if closed.eql?(total)
      (1.0 - (open.to_f / total.to_f)) * 100
    end

    # Shortens a full repository name
    def shorten_repo_name repo_full_name
      path_index = (repo_full_name.index('/') || -1)
      repo_full_name[(path_index + 1)..repo_full_name.length]
    end

    # Will raise error if not GitHub milestone URL
    def repo_name_from_milestone_url milestone_url
      org_name    = @options[:organization]
      start_index = (milestone_url.index(org_name) + (org_name.length + 1))
      end_index   = (milestone_url.rindex('milestones') - 2)
      milestone_url[start_index..end_index]
    end

    def last_year_commit_stat repo_name
      stats  = RetryableCall.perform { @client.commit_activity_stats(full_repo_name(repo_name)) }
      week = 0
      start_date = 1.year.ago.to_date
      repo_stats = Hash.new
      stats.map do |commit_stat|
        week            += 7
        date             = start_date + week
        repo_stats[date] = commit_stat.total
      end
      {
        name:  repo_name,
        data:  repo_stats
      }
    end

    def full_repo_name repo_name
      "#{@options[:organization]}/#{repo_name}"
    end

end
