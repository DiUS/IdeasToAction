require 'spec_helper'

describe IdeaView do
  let(:idea_view) { IdeaView.new }

  context "featured ideas" do
    it "should contain ideas" do
      idea_view.featured.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have one" do
      idea_view.featured.size.should eql(1)
    end
  end

  context "recent ideas" do
    it "should contain ideas" do
      idea_view.recent.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have two" do
      idea_view.recent.size.should eql(2)
    end
  end

  context "popular ideas" do
    it "should contain ideas" do
      idea_view.popular.each do |idea|
        idea.should be_an_instance_of(Idea)
      end
    end

    it "should have two" do
      idea_view.popular.size.should eql(2)
    end
  end
end
