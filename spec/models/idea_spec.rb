require 'spec_helper'

describe Idea do

  it { should be_accessible(:tags) }
  it { should be_accessible(:talks) }
  it { should be_accessible(:description) }
  it { should be_accessible(:idea_actions) }
  it { should be_accessible(:featured) }
  it { should be_accessible(:member_id) }
  it { should be_accessible(:talk_ids) }
  it { should be_accessible(:idea_actions_attributes) }
  it { should be_accessible(:member) }

	it { should accept_nested_attributes_for :idea_actions }

  it { should delegate(:email).to(:member).with_prefix }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:member) }

  describe "collection methods" do
    describe "self.random" do
      subject{Idea}

      it "should return random ideas" do
        member_objects = []
        100.times{member_objects << subject.random}
        expect(member_objects.frequencies.values.max).to be <= 100/subject.count * 3
      end

      it "should return a given number of random ideas" do
        expect(subject.random(2).count).to eq 2
      end
    end

    describe "self.featured" do
      it "should return featured ideas" do
        ideas = Idea.featured
        ideas.each{|idea| idea.featured?.should be_true}
      end
    end

    describe "self.recent" do
      it 'should return recent ideas' do
        ideas = Idea.recent
        ideas.should include(Idea.order("created_at desc").first)
      end
    end

    describe "self.popular" do
      it 'should return popular ideas' do
        ideas = Idea.popular
        ideas.should include(Idea.order("idea_actions_count desc").first)
      end
    end

    describe "self.excluding_ideas" do
      it 'should return exclude specific idea' do
        idea_to_exclude = Idea.first
        Idea.excluding_ideas([idea_to_exclude.id]).should_not include(idea_to_exclude)
      end
    end

    describe "self.descriptions" do
      let(:idea1){double(Idea, id: 1, description: 'description1')}
      let(:idea2){double(Idea, id: 2, description: 'description2')}
      let(:ideas){[idea1, idea2]}

      before do
        Idea.should_receive(:all).and_return(ideas)
      end

      it "should work" do
        expect(Idea.descriptions).to eq [["(1) description1", 1], ["(2) description2", 2]]
      end
    end

    describe "self.viewable" do

    end

    describe "self.total" do
			it 'should count the viewable ideas' do
				viwable_ideas = double
				Idea.should_receive(:viewable).and_return(viwable_ideas)
				viwable_ideas.should_receive(:count)
				Idea.total
			end
		end

		describe 'bitly url' do
			it 'calls the bitly service' do
				bitly_mock = double
				Bitly.should_receive(:new).with(ENV['BITLY_USERNAME'], ENV['BITLY_API_KEY']).and_return(bitly_mock)
				bitly_mock.should_receive(:shorten).and_return(bitly_mock)
				bitly_mock.should_receive(:short_url).and_return('http://1234')
				subject.bitly_url
			end
		end
  end

  describe 'member methods' do
    describe "#member" do
      let(:idea) { Idea.first }
      let(:member) { Member.first }

      it "should belong to a member" do
        idea.member = member
        idea.save!
        idea.reload
        idea.member.should eq member
      end

      it "should be required" do
        idea.should be_valid
        idea.member = nil
        idea.should_not be_valid
      end
    end

    describe "#talks" do
      let(:idea) { Idea.first }

      it { should have_many(:talks).through(:talk_to_idea_associations) }

      it "should require at least one" do
        idea.should be_valid
        idea.talks = []
        idea.should_not be_valid
      end
    end
  end

  describe "tags" do
    let(:idea) { Idea.first }
    let(:tag) { Tag.first }
    let(:another_tag) { Tag.last }

    it { should have_and_belong_to_many(:tags) }

    it 'should have and belong to many tags' do
      tag.should_not be_nil
      another_tag.should_not be_nil

      idea.tags << tag
      idea.tags << another_tag

      idea.save!

      idea.tags.should include tag
      idea.tags.should include another_tag
    end
  end

  describe "counters" do
    let (:event) { Event.first }
    let (:talk) { event.talks.first }

    it { should have_many(:idea_actions).dependent(:destroy) }

    describe "on events" do
      it "should be incremented when idea is created" do
        expect {
          Idea.create!(:talks => [talk], :member_id => Member.first.id, :description => "test idea")
        }.to increment_counter_on(event).for(Idea)
      end

      it "should be decremented when idea is destroyed" do
        new_idea = Idea.create!(:talks => [talk], :member_id => Member.first.id, :description => "test idea")
        expect {
          new_idea.destroy
        }.to decrement_counter_on(event).for(Idea)
      end
    end

    describe "on talks" do
      it "should be incremented when idea is created" do
        expect {
          Idea.create!(:talks => [talk], :member_id => Member.first.id, :description => "test idea")
        }.to increment_counter_on(talk).for(Idea)
      end

      it "should be decremented when idea is destroyed" do
        new_idea = Idea.create!(:talks => [talk], :member_id => Member.first.id, :description => "test idea")
        expect {
          new_idea.destroy
        }.to decrement_counter_on(talk).for(Idea)
      end
    end
  end

end
