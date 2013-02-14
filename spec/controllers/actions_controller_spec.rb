require 'spec_helper'

describe ActionsController do

  def valid_session
    {}
  end

  def valid_attributes
    { }
  end

  describe 'GET random' do
    it 'gets recent ideas' do
      action = Action.first
      Action.should_receive(:find).with(:first, :order => 'rand()').and_return action
      get :random, { :format => :json }
      response.body.should eql action.to_json
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
