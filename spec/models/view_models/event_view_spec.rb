require 'spec_helper'

describe EventView do
  subject{EventView.new}

  context "featured events" do
    it "should contain events" do
      subject.featured.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have one" do
      subject.featured.size.should eql(1)
    end
  end

  context "recent events" do
    it "should contain events" do
      subject.recent.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have two" do
      subject.recent.size.should eql(2)
    end
  end

  context "popular events" do
    it "should contain events" do
      subject.popular.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have two" do
      subject.popular.size.should eql(2)
    end
  end
end
