require 'spec_helper'

describe TalksController do
  let(:event) { Event.find(1) }
  let(:talk) { event.talks.first }

  describe 'GET index' do
    it 'gets nothing without params' do
      get :index, {:event_id => 1, :format => 'json'}
      response.body.should be_blank
      response.should be_success
    end

    it 'gets events when mix is set to true' do
      get :index, {:event_id => 1, :format => 'json', :mix => 'true'}
      response.body.should_not be_blank
      response.should be_success
      assigns(:talk_view).should_not be_nil
    end
  end

  describe 'GET show' do
    it 'should do its thing' do
      get :show, { :id => talk.id, :format => :json }
      assigns(:talk).should eql talk
    end
  end

  describe 'PUT update' do
    let(:attrs) { { :description => 'a description' } }

    before do
      attrs[:ideas] = [Idea.last.as_json, Idea.first.as_json]
    end

    it 'should update the talk' do
      put :update, { :id => talk.id, :talk => attrs, :format => :json }
      response.should be_success
    end
  end
end