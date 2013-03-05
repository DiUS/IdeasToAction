require 'spec_helper'

describe EventsController do
  def valid_attributes
    { :name => 'event', :description => 'description', :hero_image_url => 'http://www.google.com' }
  end

  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested idea as @idea" do
      event = Event.create! valid_attributes
      get :show, {:id => event.to_param}, valid_session
      assigns(:event).should eq(event)
    end
  end

  describe 'GET ideas' do
    it 'gets ideas' do
      event_chain = mock :event
      Event.should_receive(:find).with('1').and_return event_chain
      event_chain.should_receive(:ideas)
      get :ideas, {:id => 1, :format => 'json'}, valid_session
    end
  end

  describe 'GET index' do
    it 'gets all events' do
      Event.should_receive(:all)
      get :index, {:format => 'json'}, valid_session
    end
  end
end