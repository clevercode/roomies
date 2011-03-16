require 'spec_helper'

describe "expenses/edit.html.haml" do
  before(:each) do
    @expense = assign(:expense, stub_model(Expense,
      :purpose => "MyString",
      :cost => 1.5
    ))
  end

  it "renders the edit expense form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => expenses_path(@expense), :method => "post" do
      assert_select "input#expense_purpose", :name => "expense[purpose]"
      assert_select "input#expense_cost", :name => "expense[cost]"
    end
  end
end
