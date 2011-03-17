require 'spec_helper'

describe "achievements/edit.html.haml" do
  before(:each) do
    @achievement = assign(:achievement, stub_model(Achievement,
      :name => "MyString",
      :value => 1,
      :badge => "MyString"
    ))
  end

  it "renders the edit achievement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => achievements_path(@achievement), :method => "post" do
      assert_select "input#achievement_name", :name => "achievement[name]"
      assert_select "input#achievement_value", :name => "achievement[value]"
      assert_select "input#achievement_badge", :name => "achievement[badge]"
    end
  end
end
