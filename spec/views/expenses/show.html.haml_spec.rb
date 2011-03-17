require 'spec_helper'

describe "expenses/show.html.haml" do
  before(:each) do
    @expense = assign(:expense, stub_model(Expense,
      :purpose => "Purpose",
      :cost => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Purpose/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
  end
end
