require 'spec_helper'

describe DeploymentsController do

  # This should return the minimal set of attributes required to create a valid deployment
  def valid_attributes
    { commit_sha: '0123456789', application: 'application_name', repository_name: 'repo_name', server: 'server-name' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in DeploymentsController.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all deployments as @deployments" do
      deployment = Deployment.create! valid_attributes
      get :index, {}, valid_session
      assigns(:deployments).should eq([deployment])
    end
  end

  describe "GET show" do
    it "assigns the requested deployment as @deployment" do
      deployment = Deployment.create! valid_attributes
      get :show, {:id => deployment.to_param}, valid_session
      assigns(:deployment).should eq(deployment)
    end
  end

  describe "GET new" do
    it "assigns a new deployment as @deployment" do
      get :new, {}, valid_session
      assigns(:deployment).should be_a_new(Deployment)
    end
  end

  describe "GET edit" do
    it "assigns the requested deployment as @deployment" do
      deployment = Deployment.create! valid_attributes
      get :edit, {:id => deployment.to_param}, valid_session
      assigns(:deployment).should eq(deployment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Deployment" do
        expect {
          post :create, {:deployment => valid_attributes}, valid_session
        }.to change(Deployment, :count).by(1)
      end

      it "assigns a newly created deployment as @deployment" do
        post :create, {:deployment => valid_attributes}, valid_session
        assigns(:deployment).should be_a(Deployment)
        assigns(:deployment).should be_persisted
      end

      it "redirects to the created deployment" do
        post :create, {:deployment => valid_attributes}, valid_session
        response.should redirect_to(Deployment.last)
      end
    end


    describe "with invalid params" do
      it "assigns a newly created but unsaved deployment as @deployment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Deployment.any_instance.stub(:save).and_return(false)
        post :create, {:deployment => { commit_sha: '' }}, valid_session
        assigns(:deployment).should be_a_new(Deployment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Deployment.any_instance.stub(:save).and_return(false)
        post :create, {:deployment => { commit_sha: '' }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "POST create_remote_deployment" do
    describe "with valid params" do
      it "creates a new Deployment" do
        expect {
          post :create_remote_deployment, {:deployment => valid_attributes}, valid_session
        }.to change(Deployment, :count).by(1)
      end

      it "assigns a newly created deployment as @deployment" do
        post :create_remote_deployment, {:deployment => valid_attributes}, valid_session
        assigns(:deployment).should be_a(Deployment)
        assigns(:deployment).should be_persisted
      end

      it "returns 200 and JSON on created deployment" do
        post :create_remote_deployment, {:deployment => valid_attributes}, valid_session
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq(200)
        expect(json["notice"]).to eq('Deployment was successfully created.')
      end
    end


    describe "with invalid params" do
      it "renders 500" do
        # Trigger the behavior that occurs when invalid params are submitted
        Deployment.any_instance.stub(:save).and_return(false)
        post :create_remote_deployment, {:deployment => { commit_sha: '' }}, valid_session
        expect(response.status).to eq(500)
        json = JSON.parse(response.body)
        expect(json["status"]).to eq(500)
        expect(json["notice"]).to eq('Deployment could not be saved.')
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested deployment" do
        deployment = Deployment.create! valid_attributes
        new_sha = '9876543210'
        Deployment.any_instance.should_receive(:update).with({ 'commit_sha' => new_sha })
        put :update, {:id => deployment.to_param, :deployment => { 'commit_sha' => new_sha }}, valid_session
      end

      it "assigns the requested deployment as @deployment" do
        deployment = Deployment.create! valid_attributes
        put :update, {:id => deployment.to_param, :deployment => valid_attributes}, valid_session
        assigns(:deployment).should eq(deployment)
      end

      it "redirects to the deployment" do
        deployment = Deployment.create! valid_attributes
        put :update, {:id => deployment.to_param, :deployment => valid_attributes}, valid_session
        response.should redirect_to(deployment)
      end
    end

    describe "with invalid params" do
      it "assigns the deployment as @deployment" do
        deployment = Deployment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Deployment.any_instance.stub(:save).and_return(false)
        put :update, {:id => deployment.to_param, :deployment => { commit_sha: '' }}, valid_session
        assigns(:deployment).should eq(deployment)
      end

      it "re-renders the 'edit' template" do
        deployment = Deployment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Deployment.any_instance.stub(:save).and_return(false)
        put :update, {:id => deployment.to_param, :deployment => { commit_sha: '' }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested deployment" do
      deployment = Deployment.create! valid_attributes
      expect {
        delete :destroy, {:id => deployment.to_param}, valid_session
      }.to change(Deployment, :count).by(-1)
    end

    it "redirects to the deployments list" do
      deployment = Deployment.create! valid_attributes
      delete :destroy, {:id => deployment.to_param}, valid_session
      response.should redirect_to(deployments_url)
    end
  end

  describe "GET latest_by_app_server" do
    it "returns 200 response and returns JSON" do
      get :latest_by_app_server
      expect(response.status).to eq(200)
    end
  end

end
