require 'spec_helper'

describe "ideas/show" do
  before(:each) do
    @idea = assign(:idea, stub_model(Idea,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
