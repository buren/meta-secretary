module Github
  class Organization

    def Organization.new(client, organization_name)
      begin
        github_org = client.organization(organization_name)
        super(client, organization_name, github_org)
      rescue Exception => e
        NilOrganization.new(client)
      end
    end

    def initialize(client, organization_name, github_org)
      @client   = client
      @org_name = organization_name
      @org      = github_org
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

      def initialize(client)
        @client = client
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
