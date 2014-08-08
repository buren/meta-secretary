require 'spec_helper'

describe "deployments/new" do
  before(:each) do
    assign(:deployment, stub_model(Deployment).as_new_record)
  end

  it "renders new deployment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deployments_path, "post" do
    end
  end
end
