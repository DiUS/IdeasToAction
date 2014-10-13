require 'spec_helper'

describe TalkView do
  subject{TalkView.new}

  describe "#set_featured" do
    it "should contain talks" do
      subject.set_featured.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have one" do
      subject.set_featured.size.should eql(1)
    end

    it "should be viewable" do
      expect(subject.set_featured.first.viewable?).to be true
    end
  end

  describe "#set_recent" do
    it "should contain talks" do
      subject.set_recent.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have two" do
      subject.set_recent.size.should eql(2)
    end

    it "should be viewable" do
      expect(subject.set_recent.all?{|recent_talk| recent_talk.viewable?}).to be true
    end
  end

  describe "set_popular" do
    it "should contain talks" do
      subject.set_popular.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have two" do
      subject.set_popular.size.should eql(2)
    end

    it "should be viewable" do
      expect(subject.set_popular.all?{|popular_talk| popular_talk.viewable?}).to be true
    end
  end

end
