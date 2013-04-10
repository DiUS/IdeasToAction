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

    it "should have 2 recent ideas" do
      @rendered.should have_json_size(2).at_path("recent")
    end
  end

  context "popular ideas" do
    it "should include a collection of popular ideas" do
      @rendered.should have_json_path("popular")
      @rendered.should have_json_type(Array).at_path("popular")
    end

    it "should have 2 popular ideas" do
      @rendered.should have_json_size(2).at_path("popular")
    end
  end
end