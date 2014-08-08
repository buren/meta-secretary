require 'spec_helper'

describe "deployments/show" do
  before(:each) do
    @deployment = assign(:deployment, stub_model(Deployment))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
