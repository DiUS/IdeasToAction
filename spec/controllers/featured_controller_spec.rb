 require 'spec_helper'

describe FeaturedController do

  describe "GET index" do
    before do
      Event.should_receive(:find_all_by_featured).with(true).and_return(Event.first)
      Talk.should_receive(:find_all_by_featured).with(true).and_return(Talk.first)
      Idea.should_receive(:find_all_by_featured).with(true).and_return(Idea.first)
      Action.should_receive(:find_all_by_featured).with(true).and_return(Action.first)
    end

    it "returns counts for member, idea and actions taken" do
      get :index

      response.body.should == {
        :events => Event.first,
        :talks => Talk.first,
        :ideas => Idea.first,
        :actions => Action.first
      }.to_json
    end
  end
end