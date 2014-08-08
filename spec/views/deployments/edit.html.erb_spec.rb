require 'spec_helper'

describe "deployments/edit" do
  before(:each) do
    @deployment = assign(:deployment, stub_model(Deployment))
  end

  it "renders the edit deployment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deployment_path(@deployment), "post" do
    end
  end
end
