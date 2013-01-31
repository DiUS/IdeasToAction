require 'spec_helper'

describe "ideas/edit" do
  before(:each) do
    @idea = assign(:idea, stub_model(Idea,
      :body => "MyText"
    ))
  end

  it "renders the edit idea form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ideas_path(@idea), :method => "post" do
      assert_select "textarea#idea_body", :name => "idea[body]"
    end
  end
end
