require 'spec_helper'

describe "expenses/index.html.haml" do
  before(:each) do
    assign(:expenses, [
      stub_model(Expense,
        :purpose => "Purpose",
        :cost => 1.5
      ),
      stub_model(Expense,
        :purpose => "Purpose",
        :cost => 1.5
      )
    ])
  end

  it "renders a list of expenses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
