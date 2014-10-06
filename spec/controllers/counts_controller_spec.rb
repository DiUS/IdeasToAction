require 'spec_helper'

describe CountsController do

  describe "GET index" do
    before do
      Idea.should_receive(:total).and_return(6)
      IdeaAction.should_receive(:total).and_return(7)
      Talk.should_receive(:total).and_return(8)
      Event.should_receive(:total).and_return(5)
    end

    it "returns counts for member, idea and actions taken" do
      get :index
      expect(response.body).to eq({ideas: 6, idea_actions: 7, talks: 8, events: 5}.to_json)
    end
  end

end
