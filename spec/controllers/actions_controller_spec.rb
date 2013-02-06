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

end
