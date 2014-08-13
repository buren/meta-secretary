module Github
  class ApiProxy

    def initialize(access_token)
      @access_token = access_token
    end

    def client
      @client ||= Octokit::Client.new(access_token: @access_token)
    end

    def list_repositories
      client.list_repositories
    end

    def list_milestones(repository)
      client.list_milestones(repository) rescue Array.new # Raises error if milestones are disabled for that repository
    end

    def issues(repo_name)
      client.issues(repo_name) rescue Array.new # Raises error if issues are disabled for that repository
    end

    def commits(repo_name)
      client.commits(repo_name)
    end

    def commit(repo_name, commit_sha)
      client.commit(repo_name, commit_sha)
    end

    def commits_before(repo_name, before_date, commit_sha)
      client.commits_before(repo_name, before_date, commit_sha)
    end

    def user
      client.user
    end

    def commit_activity_stats(repo_name)
      client.commit_activity_stats(repo_name)
    end

    def organization(organization_name)
      client.organization(organization_name)
    end

    def organization_repositories(organization_name)
      client.organization_repositories(organization_name)
    end

    def organization_teams(organization_name)
      client.organization_teams(organization_name)
    end

    def organization_members(organization_name)
      client.organization_members(organization_name)
    end

  end
end
