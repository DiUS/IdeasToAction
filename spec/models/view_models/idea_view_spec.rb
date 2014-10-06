require 'spec_helper'

describe IdeaView do
  subject{IdeaView.new}

  context "featured ideas" do
    it "should contain ideas" do
      subject.featured.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have one" do
      subject.featured.size.should eql(1)
    end
  end

  context "recent ideas" do
    it "should contain ideas" do
      subject.recent.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have two" do
      subject.recent.size.should eql(2)
    end
  end

  context "popular ideas" do
    it "should contain ideas" do
      subject.popular.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have two" do
      subject.popular.size.should eql(2)
    end
  end
end
