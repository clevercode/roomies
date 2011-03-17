require 'spec_helper'

describe "chores/new.html.haml" do
  before(:each) do
    assign(:chore, stub_model(Chore,
      :purpose => "MyString"
    ).as_new_record)
  end

  it "renders new chore form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chores_path, :method => "post" do
      assert_select "input#chore_purpose", :name => "chore[purpose]"
    end
  end
end
