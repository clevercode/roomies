require 'spec_helper'

describe "chores/show.html.haml" do
  before(:each) do
    @chore = assign(:chore, stub_model(Chore,
      :purpose => "Purpose"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Purpose/)
  end
end
