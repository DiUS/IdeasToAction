require 'spec_helper'

describe "talks/index" do
  before(:each) do
    assign(:talks, [
      stub_model(Talk,
        :title => "MyText",
        :description => "MyDescText"
      ),
      stub_model(Talk,
        :title => "MyText",
        :description => "MyDescText"
      )
    ])
  end

  it "renders a list of talks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyDescText".to_s, :count => 2
  end
end
