module OctokitClientMock

  MOCK_COMMIT = OpenStruct.new({
    repo: 'mock-repo',
    sha: '9ea6a6dd5439843ad238ca761d0df102bf4dda93',
    commit: OpenStruct.new({
      author: OpenStruct.new({
        name: 'Jacob Burenstam',
        date: Date.new(2010, 1, 1)
      }),
      message: 'dummy-commit-message'
    })
  })

  module_function

    def set_mock_client(client)
      @client = client
     end

    def list_repositories
      Array.new
    end

    def list_milestones(repository)
      Array.new
    end

    def issues(repo_name)
      Array.new
    end

    def commits(repo_name)
      [MOCK_COMMIT]
    end

    def commit(repo_name, commit_sha)
      MOCK_COMMIT
    end

    def commits_before(repo_name, before_date, commit_sha)
      Array.new(30) { MOCK_COMMIT }
    end

    def user
      OpenStruct.new
    end

    def commit_activity_stats(repo_name)
      Array.new
    end

end
