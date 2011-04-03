require 'spec_helper'

describe "tascs/edit.html.haml" do
  before(:each) do
    @tasc = assign(:tasc, stub_model(Tasc,
      :purpose => "MyString"
    ))
  end

  it "renders the edit tasc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tascs_path(@tasc), :method => "post" do
      assert_select "input#tasc_purpose", :name => "tasc[purpose]"
    end
  end
end
