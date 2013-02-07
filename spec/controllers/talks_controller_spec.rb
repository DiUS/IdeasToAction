require 'spec_helper'

describe TalksController do
  describe 'GET index' do
    let(:event) { Event.find(1) }
    let(:talk) { event.talks.first }

    let(:other_event) { Event.find(2) }
    let(:other_talk) { other_event.talks.first }

    it "should nest in events" do
      get :index, { :event_id => 1, :format => 'json'}

      assigns(:talks).should include(talk)
      assigns(:talks).should_not include(other_talk)
    end
  end
end