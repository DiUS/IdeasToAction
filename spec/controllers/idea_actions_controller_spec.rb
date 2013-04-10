require 'spec_helper'

describe IdeaActionsController do

  def valid_session
    {}
  end

  def valid_attributes
    { }
  end

  describe 'GET random' do
    it 'gets featured ideas' do
      action = IdeaAction.featured.first
      IdeaAction.stub_chain(:featured, :random).and_return [action]
      get :random, { :format => :json }
      response.body.should eql action.to_json
    end
  end

  describe 'GET index' do
    let(:idea) { Idea.find(1) }
    let(:idea_action) { idea.idea_actions.first }

    let(:other_idea) { Idea.find(2) }
    let(:other_action) { other_idea.idea_actions.first }

    it "should nest in ideas" do
      get :index, { :idea_id => 1, :format => 'json'}, valid_session

      assigns(:idea_actions).should include(idea_action)
      assigns(:idea_actions).should_not include(other_action)
    end


    it "should work when not nesting" do
      get :index, { :format => 'json'}, valid_session

      assigns(:idea_actions).should include(idea_action)
      assigns(:idea_actions).should include(other_action)
    end
  end
end
