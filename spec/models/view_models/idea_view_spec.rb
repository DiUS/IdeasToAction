require 'spec_helper'

describe IdeaView do
  subject{IdeaView.new}

  describe "#set_featured" do
    it "should contain ideas" do
      subject.set_featured.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have one" do
      subject.set_featured.size.should eql(1)
    end
  end

  describe "#set_recent" do
    it "should contain ideas" do
      subject.set_recent.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have two" do
      subject.set_recent.size.should eql(2)
    end
  end

  describe "#set_popular" do
    it "should contain ideas" do
      subject.set_popular.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have two" do
      subject.set_popular.size.should eql(2)
    end
  end
end
