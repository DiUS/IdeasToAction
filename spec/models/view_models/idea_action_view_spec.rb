require 'spec_helper'

describe IdeaActionView do
  subject{IdeaActionView.new}

  context "featured idea actions" do
    it "should contain idea actions" do
      subject.featured.each do |idea|
        idea.should be_an_instance_of(IdeaAction)
      end
    end

    it "should have one" do
      subject.featured.size.should eql 1
    end
  end

  context "recent idea actions" do
    it "should contain idea actions" do
      subject.recent.each do |idea|
        idea.should be_an_instance_of(IdeaAction)
      end
    end

    it "should have four" do
      subject.recent.size.should eql 4
    end
  end
end
