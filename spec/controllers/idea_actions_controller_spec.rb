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
