require 'spec_helper'

describe "tascs/index.html.haml" do
  before(:each) do
    assign(:tascs, [
      stub_model(Tasc,
        :purpose => "Purpose"
      ),
      stub_model(Tasc,
        :purpose => "Purpose"
      )
    ])
  end

  it "renders a list of tascs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
  end
end