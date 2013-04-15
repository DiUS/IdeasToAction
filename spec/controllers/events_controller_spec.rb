require 'spec_helper'

describe EventsController do
  def valid_event_attributes
    { :name => 'event', :description => 'description', :hero_image_url => 'http://www.google.com' }
  end

  def valid_talk_attributes
    { :title => 'talk', :description => 'description', :event_id => Event.first.id}
  end

  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested idea as @idea" do
      event = Event.create! valid_event_attributes
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
    it 'gets nothing without params' do
      get :index, {:format => 'json'}, valid_session
      response.body.should be_blank
      response.should be_success
    end

    it 'gets events when mix is set to true' do
      get :index, {:format => 'json', :mix => 'true'}, valid_session
      response.body.should_not be_blank
      response.should be_success
      assigns(:event_view).should_not be_nil
    end

    describe 'excluding certain events' do
      let(:event_ids) { '1,2,3,4,5' }
      let(:events)   { ['event1', 'event2'] }
      let(:excluded_events) { mock('excluded_events') }

      before do
        Event.should_receive(:excluding_events).with(event_ids.split(',')).and_return(excluded_events)
        excluded_events.should_receive(:random).with(5).and_return(events)
        get :index, {:format => 'json', :excluding => event_ids}, valid_session
      end

      it 'gets events excluding the list provided in the params' do
        response.body.should eql events.to_json
        response.should be_success
      end
    end
  end

  describe 'as a content admin' do
    let(:admin_member) { Member.create!(:username => "ted", :password => "admin", :role => Member::ROLE_CONTENT_ADMIN) }
    before do
      controller.stub(:current_member).and_return(admin_member)
    end

    describe 'PUT update' do
      let(:event) {Event.create! valid_event_attributes}
      let(:attrs) {valid_event_attributes}

      before do
        attrs[:name] = 'my new event name'
        attrs[:talks] = [Talk.create!(valid_talk_attributes).as_json, Talk.create!(valid_talk_attributes).as_json]
      end

      it 'should update the event' do
        put :update, { :id => event.id, :event => attrs, :format => :json }, valid_session
        response.should be_success
      end
    end

    describe 'DELETE destroy' do
      let(:event) { Event.create!(name: 'temp_event', description: 'my desc', hero_image_url: 'http://www.google.com/image.png') }
      
      before { Event.find(event.id).should_not be_nil }

      it 'should delete the event' do
        delete :destroy, {:id => event.id, :format => 'json'}, valid_session

        assert_raise(ActiveRecord::RecordNotFound) do
          Event.find(event.id)
        end
      end
    end
  end
end