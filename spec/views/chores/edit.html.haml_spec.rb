require 'spec_helper'

describe "chores/edit.html.haml" do
  before(:each) do
    @chore = assign(:chore, stub_model(Chore,
      :purpose => "MyString"
    ))
  end

  it "renders the edit chore form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chores_path(@chore), :method => "post" do
      assert_select "input#chore_purpose", :name => "chore[purpose]"
    end
  end
end
