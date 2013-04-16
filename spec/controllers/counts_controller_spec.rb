require 'spec_helper'

describe CountsController do

  describe "GET index" do
    before do
      Event.should_receive(:count).and_return(5)
      Idea.should_receive(:count).and_return(6)
      IdeaAction.should_receive(:count).and_return(7)
      Talk.should_receive(:count).and_return(8)
    end

    it "returns counts for member, idea and actions taken" do
      get :index
      response.body.should == { :events => 5, :talks => 8, :ideas => 6, :idea_actions => 7 }.to_json
    end
  end
end