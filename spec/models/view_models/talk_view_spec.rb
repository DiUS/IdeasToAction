require 'spec_helper'

describe TalkView do
  let(:talk_view) { TalkView.new }

  context "featured talks" do
    it "should contain talks" do
      talk_view.featured.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have one" do
      talk_view.featured.size.should eql(1)
    end

    it "should be viewable" do
      expect(talk_view.featured.first.viewable?).to be true
    end
  end

  context "recent talks" do
    it "should contain talks" do
      talk_view.recent.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have two" do
      talk_view.recent.size.should eql(2)
    end

    it "should be viewable" do
      expect(talk_view.recent.all?{|recent_talk| recent_talk.viewable?}).to be true
    end
  end

  context "popular talks" do
    it "should contain talks" do
      talk_view.popular.each do |event|
        event.should be_an_instance_of(Talk)
      end
    end

    it "should have two" do
      talk_view.popular.size.should eql(2)
    end

    it "should be viewable" do
      expect(talk_view.popular.all?{|popular_talk| popular_talk.viewable?}).to be true
    end
  end

end
