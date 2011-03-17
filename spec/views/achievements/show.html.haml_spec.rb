require 'spec_helper'

describe "achievements/show.html.haml" do
  before(:each) do
    @achievement = assign(:achievement, stub_model(Achievement,
      :name => "Name",
      :value => 1,
      :badge => "Badge"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Badge/)
  end
end
