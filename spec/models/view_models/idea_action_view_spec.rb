require 'spec_helper'

describe IdeaActionView do
  subject{IdeaActionView.new}

  describe "#set_featured" do
    it "should contain idea actions" do
      subject.set_featured.each do |idea|
        idea.should be_an_instance_of(IdeaAction)
      end
    end

    it "should have one" do
      subject.set_featured.size.should eql 1
    end
  end

  describe "#set_recent" do
    it "should contain idea actions" do
      subject.set_recent.each do |idea|
        idea.should be_an_instance_of(IdeaAction)
      end
    end

    it "should have four" do
      subject.set_recent.size.should eql 4
    end
  end
end
