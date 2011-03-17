require 'spec_helper'

describe "houses/show.html.haml" do
  before(:each) do
    @house = assign(:house, stub_model(House,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
