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
  end
end