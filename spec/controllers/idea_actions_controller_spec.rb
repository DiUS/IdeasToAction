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
    describe "when nesting" do
      it 'gets nothing without mix param' do
        get :index, { :idea_id => 1, :format => 'json' }, valid_session
        response.body.should be_blank
        response.should be_success
      end

      it 'gets events when mix is set to true' do
        get :index, { :idea_id => 1, :format => 'json', :mix => 'true' }, valid_session
        response.body.should_not be_blank
        response.should be_success
        assigns(:idea_action_view).should_not be_nil
      end

      describe 'excluding certain idea_actions' do
        let(:idea_action_ids) { '1,2,3,4,5' }
        let(:idea_actions)   { ['idea_action1', 'idea_action2'] }
        let(:excluded_idea_actions) { mock('excluded_idea_actions') }

        before do
          IdeaAction.should_receive(:excluding_idea_actions).with(idea_action_ids.split(',')).and_return(excluded_idea_actions)
          excluded_idea_actions.should_receive(:random).with(5).and_return(idea_actions)
          get :index, {:format => 'json', :excluding => idea_action_ids}, valid_session
        end

        it 'gets idea_actions excluding the list provided in the params' do
          response.body.should eql idea_actions.to_json
          response.should be_success
        end
      end
    end

    describe "without nesting" do
      it 'gets nothing without mix param' do
        get :index, { :format => 'json' }, valid_session
        response.body.should be_blank
        response.should be_success
      end

      it 'gets events when mix is set to true' do
        get :index, { :format => 'json', :mix => 'true' }, valid_session
        response.body.should_not be_blank
        response.should be_success
        assigns(:idea_action_view).should_not be_nil
      end
    end
  end
end
