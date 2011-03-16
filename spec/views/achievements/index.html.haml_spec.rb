require 'spec_helper'

describe "achievements/index.html.haml" do
  before(:each) do
    assign(:achievements, [
      stub_model(Achievement,
        :name => "Name",
        :value => 1,
        :badge => "Badge"
      ),
      stub_model(Achievement,
        :name => "Name",
        :value => 1,
        :badge => "Badge"
      )
    ])
  end

  it "renders a list of achievements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Badge".to_s, :count => 2
  end
end
