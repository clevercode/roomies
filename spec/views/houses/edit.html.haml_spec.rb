require 'spec_helper'

describe "houses/edit.html.haml" do
  before(:each) do
    @house = assign(:house, stub_model(House,
      :name => "MyString"
    ))
  end

  it "renders the edit house form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => houses_path(@house), :method => "post" do
      assert_select "input#house_name", :name => "house[name]"
    end
  end
end
