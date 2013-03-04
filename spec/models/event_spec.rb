require 'spec_helper'

describe Event do

  let(:event) { Event.new() }

  before { event.save }

  it 'validate the presence of name' do
    event.errors.messages[:name].should include "can't be blank"
  end

  it 'validate the presence of description' do
    event.errors.messages[:description].should include "can't be blank"
  end

  it 'validate the presence of logo_image_url' do
    event.errors.messages[:logo_image_url].should include "can't be blank"
  end

  it 'validate the presence of hero_image_url' do
    event.errors.messages[:hero_image_url].should include "can't be blank"
  end
end