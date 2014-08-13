module GithubOrganizationMock

  module_function

    def set_mock_organization(organization)
      @organization = organization
     end

     def exists?
       true
     end

    def repositories
      Array.new
    end

    def members
      Array.new
    end

    def teams
      Array.new
    end

    def html_url
      'https://example.com/mock-url'
    end

    def github_teams_url
      '/orgs/mock-org/teams'
    end

 end
