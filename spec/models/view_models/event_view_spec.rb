require 'spec_helper'

describe EventView do
  subject{EventView.new}

  describe "#set_featured" do
    it "should contain events" do
      subject.set_featured.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have one" do
      subject.set_featured.size.should eql(1)
    end
  end

  context "#set_recent" do
    it "should contain events" do
      subject.set_recent.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have two" do
      subject.set_recent.size.should eql(2)
    end
  end

  context "#set_popular" do
    it "should contain events" do
      subject.set_popular.each do |event|
        event.should be_an_instance_of(Event)
      end
    end

    it "should have two" do
      subject.set_popular.size.should eql(2)
    end
  end
end
