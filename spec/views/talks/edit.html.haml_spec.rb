require 'spec_helper'

describe "talks/edit" do
  before(:each) do
    @talk = assign(:talk, stub_model(Talk,
      :title => "MyText",
      :description => "MyText"
    ))
  end

  it "renders the edit talk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talks_path(@talk), :method => "post" do
      assert_select "textarea#talk_title", :name => "talk[title]"
      assert_select "textarea#talk_description", :name => "talk[description]"
    end
  end
end
