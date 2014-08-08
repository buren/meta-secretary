require "spec_helper"

describe DeploymentsController do
  describe "routing" do

    it "routes to #index" do
      get("/deployments").should route_to("deployments#index")
    end

    it "routes to #new" do
      get("/deployments/new").should route_to("deployments#new")
    end

    it "routes to #show" do
      get("/deployments/1").should route_to("deployments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deployments/1/edit").should route_to("deployments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deployments").should route_to("deployments#create")
    end

    it "routes to #update" do
      put("/deployments/1").should route_to("deployments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deployments/1").should route_to("deployments#destroy", :id => "1")
    end

    it 'routes to #create_remote_deployment' do
      post("/new_deployment").should route_to("deployments#create_remote_deployment")
    end

    it 'routes to #diff' do
      get("/diff").should route_to("deployments#diff")
    end

    it 'routes to #diff_route' do
      get("/diff_route").should route_to("deployments#diff_route")
    end

    it 'routes to #latest_by_app_server' do
      get("/latest_by_app_server").should route_to("deployments#latest_by_app_server")
    end

  end
end
