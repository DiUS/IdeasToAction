require 'spec_helper'

describe 'idea_actions/idea_actions.json.rabl' do
  before :each do
    @idea_action_view = IdeaActionView.new
    @rendered = Rabl.render(@idea_action_view, 'idea_actions/idea_actions', :view_path => 'app/views')
  end

  context "featured ideas" do
    it "should include a collection" do
      @rendered.should have_json_path("featured")
      @rendered.should have_json_type(Array).at_path("featured")
    end

    it "should have 1 ideas" do
      @rendered.should have_json_size(1).at_path("featured")
    end
  end

  context "recent ideas" do
    it "should include a collection of recent ideas" do
      @rendered.should have_json_path("recent")
      @rendered.should have_json_type(Array).at_path("recent")
    end

    it "should have 4 recent ideas" do
      @rendered.should have_json_size(4).at_path("recent")
    end
  end
end