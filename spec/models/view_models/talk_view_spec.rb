require 'spec_helper'

describe TalkView do
  subject{TalkView.new}

  context "featured talks" do
    it "should contain talks" do
      subject.featured.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have one" do
      subject.featured.size.should eql(1)
    end

    it "should be viewable" do
      expect(subject.featured.first.viewable?).to be true
    end
  end

  context "recent talks" do
    it "should contain talks" do
      subject.recent.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have two" do
      subject.recent.size.should eql(2)
    end

    it "should be viewable" do
      expect(subject.recent.all?{|recent_talk| recent_talk.viewable?}).to be true
    end
  end

  context "popular talks" do
    it "should contain talks" do
      subject.popular.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have two" do
      subject.popular.size.should eql(2)
    end

    it "should be viewable" do
      expect(subject.popular.all?{|popular_talk| popular_talk.viewable?}).to be true
    end
  end

end
