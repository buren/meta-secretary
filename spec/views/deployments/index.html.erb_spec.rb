require 'spec_helper'

describe "deployments/index" do
  before(:each) do
    assign(:deployments, [
      stub_model(Deployment),
      stub_model(Deployment)
    ])
  end

  it "renders a list of deployments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
