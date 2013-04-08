require 'spec_helper'

describe 'events/index.json.rabl' do
  before :each do
    @event_view = EventView.new
    @rendered = Rabl.render(@event_view, 'events/index', :view_path => 'app/views')
  end

  context "featured events" do
    it "should include a collection" do
      @rendered.should have_json_path("featured")
      @rendered.should have_json_type(Array).at_path("featured")
    end

    it "should have 1 event" do
      @rendered.should have_json_size(1).at_path("featured")
    end
  end

  context "recent events" do
    it "should include a collection of recent events" do
      @rendered.should have_json_path("recent")
      @rendered.should have_json_type(Array).at_path("recent")
    end

    it "should have 2 recent event" do
      @rendered.should have_json_size(2).at_path("recent")
    end
  end

  context "popular events" do
    it "should include a collection of popular events" do
      @rendered.should have_json_path("popular")
      @rendered.should have_json_type(Array).at_path("popular")
    end

    it "should have 2 popular events" do
      @rendered.should have_json_size(2).at_path("popular")
    end
  end
end