require 'spec_helper'

describe 'talks/talks.json.rabl' do
  before :each do
    @talk_view = TalkView.new
    @rendered = Rabl.render(@talk_view, 'talks/talks', :view_path => 'app/views')
  end

  context "featured talks" do
    it "should include a collection" do
      @rendered.should have_json_path("featured")
      @rendered.should have_json_type(Array).at_path("featured")
    end

    it "should have 1 talk" do
      @rendered.should have_json_size(1).at_path("featured")
    end
  end

  context "recent talks" do
    it "should include a collection of recent talks" do
      @rendered.should have_json_path("recent")
      @rendered.should have_json_type(Array).at_path("recent")
    end

    it "should have 2 recent talk" do
      @rendered.should have_json_size(2).at_path("recent")
    end
  end

  context "popular talks" do
    it "should include a collection of popular talks" do
      @rendered.should have_json_path("popular")
      @rendered.should have_json_type(Array).at_path("popular")
    end

    it "should have 2 popular talks" do
      @rendered.should have_json_size(2).at_path("popular")
    end
  end
end