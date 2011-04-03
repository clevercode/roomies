require 'spec_helper'

describe "tascs/new.html.haml" do
  before(:each) do
    assign(:tasc, stub_model(Tasc,
      :purpose => "MyString"
    ).as_new_record)
  end

  it "renders new tasc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tascs_path, :method => "post" do
      assert_select "input#tasc_purpose", :name => "tasc[purpose]"
    end
  end
end
