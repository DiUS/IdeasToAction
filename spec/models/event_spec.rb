require 'spec_helper'

describe Event do

  describe "validations" do
    let(:event){Event.new}

    before do
      event.save
    end

    it {should have_many(:talks).dependent(:destroy)}

    it 'validates the presence of name' do
      event.errors.messages[:name].should include "can't be blank"
    end

    it 'validates the presence of description' do
      event.errors.messages[:description].should include "can't be blank"
    end

    it 'validates the presence of hero_image_url' do
      event.errors.messages[:hero_image_url].should include "can't be blank"
    end
  end

  describe "collection methods" do
    describe "self.random" do
      it "should return random events" do
        randomised_events = []
        100.times{randomised_events << Event.random}
        expect(randomised_events.frequencies.values.max).to be <= 20
      end

      it "should return a given number of random events" do
        expect(Event.random(2).count).to eq 2
      end
    end

    describe "self.featured" do
      it 'should return featured events' do
        events = Event.featured
        events.each{|event| event.featured?.should be_true}
      end
    end

    describe "self.recent" do
      it 'should return recent events' do
        events = Event.recent
        events.should include(Event.order("created_at desc").first)
      end
    end

    describe "self.popular" do
      it 'should return popular events' do
        events = Event.popular
        events.should include(Event.order("idea_actions_count desc").first)
      end
    end

    describe "self.excluding_events" do
      it 'should exclude specified events' do
        event_to_exclude = Event.first
        Event.excluding_events([event_to_exclude.id]).should_not include(event_to_exclude)
      end
    end

    describe "self.viewable" do
      subject{Event.create!(name: 'event name', description: 'event description',
        hero_image_url: 'http://hero.image.url.com')}

      before do
        Talk.create!(event: subject, title: 'talk title', description: 'talk description',
          viewable: true)
      end

      it "should find all events which are viewable" do
        expect(Event.viewable).to include(subject)
      end
    end

    describe "self.total" do
      it "should be a number" do
        expect(Event.total.class).to eq Fixnum
      end
    end
  end

  describe "member methods" do
    subject{Event.first}

    describe "idea_actions_count" do
      it "should be a number" do
        expect(subject.idea_actions_count.class).to eq Fixnum
      end
    end

    describe "ideas_count" do
      it "should be a number" do
        expect(subject.ideas_count.class).to eq Fixnum
      end
    end
  end

end
