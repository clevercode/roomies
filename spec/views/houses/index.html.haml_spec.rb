require 'spec_helper'

describe "houses/index.html.haml" do
  before(:each) do
    assign(:houses, [
      stub_model(House,
        :name => "Name"
      ),
      stub_model(House,
        :name => "Name"
      )
    ])
  end

  it "renders a list of houses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
