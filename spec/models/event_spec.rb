require 'spec_helper'

describe Event do

  let(:event) { Event.new() }

  before { event.save }

  it { should have_many(:talks).dependent(:destroy) }

  it 'validate the presence of name' do
    event.errors.messages[:name].should include "can't be blank"
  end

  it 'validate the presence of description' do
    event.errors.messages[:description].should include "can't be blank"
  end

  it 'validate the presence of hero_image_url' do
    event.errors.messages[:hero_image_url].should include "can't be blank"
  end

  it 'should return featured events' do
    events = Event.featured
    events.each{|event| event.featured?.should be_true}
  end

  it 'should return recent events' do
    events = Event.recent
    events.should include(Event.order("created_at desc").first)
  end

  it 'should return popular events' do
    events = Event.popular
    events.should include(Event.order("idea_actions_count desc").first)
  end

  it 'should exclude specified event' do
    event_to_exclude = Event.first
    Event.excluding_events([event_to_exclude]).should_not include(event_to_exclude)
  end
end