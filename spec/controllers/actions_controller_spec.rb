require 'spec_helper'

describe ActionsController do

  def valid_session
    {}
  end

  def valid_attributes
    { }
  end

  describe 'GET recent' do
    it 'gets recent actions' do
      action_chain = mock :action
      Action.should_receive(:order).with("created_at desc").and_return action_chain
      action_chain.should_receive(:limit).with(10)
      get :recent, {:format => 'json'}, valid_session
    end

    it "assigns recent actions as @actions" do
      action = Action.create! valid_attributes
      get :recent, {:format => 'json'}, valid_session
      assigns(:actions).should include(action)
    end
  end

  describe 'POST doneIt' do
    let(:member) { mock_model Member }
    let(:action) { mock_model Action }

    before :each do
      Action.should_receive(:find).and_return action
      controller.stub(:member).and_return member
    end

    it 'creates an actions taken entry' do
      ActionsTaken.should_receive(:create!).with(:member => member, :action => action)
      post :doneIt, {:id => 1, :format => 'json'}, valid_session 
    end
  end

  describe 'GET index' do
    let(:idea) { Idea.find(1) }
    let(:action) { idea.actions.first }

    let(:other_idea) { Idea.find(2) }
    let(:other_action) { other_idea.actions.first }

    it "should nest in ideas" do
      get :index, { :idea_id => 1, :format => 'json'}, valid_session

      assigns(:actions).should include(action)
      assigns(:actions).should_not include(other_action)
    end


    it "should work when not nesting" do
      get :index, { :format => 'json'}, valid_session

      assigns(:actions).should include(action)
      assigns(:actions).should include(other_action)
    end
  end
end
