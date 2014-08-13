class GithubApiMock

  def initialize(options = {})
    @github = GithubApi.new(options)
    # Include Mock objects
    @github.class.send(:include, OctokitClientMock)
    @github.class.send(:include, GithubOrganizationMock)
    # Set Mock objects
    @github.send(:set_mock_client, OctokitClientMock)
    @github.send(:set_mock_organization, GithubOrganizationMock)
  end

  # Override the client used by GithubApi
  def set_mock_client(client)
    @github.send(:set_mock_client, client)
  end

  # Override the organization used by GithubApi
  def set_mock_organization(organization)
    @github.send(:set_mock_organization, organization)
  end

  def public_repo_count
    1
  end

  def private_repo_count
    3
  end

  def last_year_commit_stats
    Array.new
  end

  def org_url
    'https://example.com/mock-url'
  end

  def total_repo_count
    public_repo_count + private_repo_count
  end

  def find_repo_by_name(name)
    repo = OpenStruct.new.tap do |repo|
      repo.name = 'mock-repo'
    end
    [repo].bsearch { |repo| repo.name.eql?(name) }
  end

  def method_missing(method, *args, &block)
    @github.send(method, *args, &block)
  end

end

module GithubControllerSetter

  module_function

    def set_github_mock(github)
      @github = github
    end

end
