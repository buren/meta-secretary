module Github
  class Organization

    def Organization.new(api_client, organization_name)
      begin
        github_org = api_client.organization(organization_name) or return NilOrganization.new(api_client)
        super(api_client, organization_name, github_org)
      rescue Exception => e
        NilOrganization.new(api_client)
      end
    end

    def initialize(client, organization_name, github_org)
      @client   = client
      @org_name = organization_name
      @org      = github_org
    end

    def exists?
      true
    end

    def repositories
      @client.organization_repositories(@org_name)
    end

    def members
      @client.organization_members(@org_name)
    end

    def teams
      @client.organization_teams(@org_name)
    end

    def github_teams_url
      "#{GithubApi::BASE_URL}/orgs/#{@org_name}/teams"
    end

    def html_url
      @org.html_url
    end

    class NilOrganization

      def initialize(api_client)
        @client = api_client
      end

      def exists?
        false
      end

      def repositories
        Array.new
      end

      def members
        Array(@client.user)
      end

      def teams
        Array.new
      end

      def method_missing(method, *args, &block)
        nil
      end

    end

  end
end
