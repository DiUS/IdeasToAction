require 'spec_helper'

describe IdeaActionView do
  let(:idea_action_view) { IdeaActionView.new }

  context "featured idea actions" do
    it "should contain idea actions" do
      idea_action_view.featured.each do |idea|
        idea.should be_an_instance_of(IdeaAction)
      end
    end

    it "should have one" do
      idea_action_view.featured.size.should eql(1)
    end
  end

  context "recent idea actions" do
    it "should contain idea actions" do
      idea_action_view.recent.each do |idea|
        idea.should be_an_instance_of(IdeaAction)
      end
    end

    it "should have two" do
      idea_action_view.recent.size.should eql(4)
    end
  end
end