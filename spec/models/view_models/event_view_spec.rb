require 'spec_helper'

describe EventView do
  let(:event_view) { EventView.new }

  context "featured events" do
    it "should contain events" do
      event_view.featured.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have one" do
      event_view.featured.size.should eql(1)
    end
  end

  context "recent events" do
    it "should contain events" do
      event_view.recent.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have two" do
      event_view.recent.size.should eql(2)
    end
  end

  context "popular events" do
    it "should contain events" do
      event_view.popular.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have two" do
      event_view.popular.size.should eql(2)
    end
  end
end
