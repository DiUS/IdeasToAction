require 'spec_helper'

describe IdeaAction do
  it { should delegate(:description).to(:idea).with_prefix }
  it { should have_many(:interactions).dependent(:destroy) }

  it { should validate_presence_of(:idea) }
  it { should validate_presence_of(:description) }

  describe 'as_json' do
    before do
      @action = IdeaAction.first
      @action.should_receive(:members_actioned).and_return [1,2,3,4,5,6]
    end

    it 'should merge members_actioned_count into the json object' do
      @action.as_json[:members_actioned_count].should_not be_nil
    end

    it 'should set the members_actioned_count to the number of unique members who have actioned' do
      @action.as_json[:members_actioned_count].should == 6
    end
  end

  describe 'members_actioned' do
    let(:action) { IdeaAction.first }

    it 'should find unique members who have actioned' do
      action.send(:members_actioned).size.should == 3
    end
  end

  describe 'interactions.from_member' do
    let(:member) { Member.first }
    let(:action) { IdeaAction.first }
    let(:interaction) { Interaction.first }

    it 'should find a single action taken from a member' do
      action.interactions.from_member(member).should eql interaction
    end
  end

  describe "scoping" do
    it "should return featured idea actions" do
      idea_actions = IdeaAction.featured
      idea_actions.each{ |idea_action| idea_action.featured?.should be_true }
    end

    it 'should return recent idea actions' do
      idea_actions = IdeaAction.recent
      idea_actions.should include(IdeaAction.order("created_at desc").first)
    end

    it 'should return popular idea actions' do
      idea_actions = IdeaAction.popular
      idea_actions.should include(IdeaAction.order("reactions_count desc").first)
    end

    it 'should return exclude specific idea actions' do
      idea_action_to_exclude = IdeaAction.first
      IdeaAction.excluding_idea_actions([idea_action_to_exclude.id]).should_not include(idea_action_to_exclude)
    end
  end

  describe "counters" do
    let(:event) { Event.first }
    let(:talk) { event.talks.first }
    let(:idea) { talk.ideas.first }

    describe "on events" do
      it "should increment the counter when created" do
        expect {
          IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        }.to increment_counter_on(event).for(IdeaAction)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        expect { idea_action.destroy }.to decrement_counter_on(event).for(IdeaAction)
      end
    end

    describe "on talks" do
      it "should increment the counter when created" do
        expect {
          IdeaAction.create!(:idea_id => idea.id, :description => "test action")
          talk.reload
        }.to increment_counter_on(talk).for(IdeaAction)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        expect { idea_action.destroy }.to decrement_counter_on(talk).for(IdeaAction)
      end
    end

    describe "on ideas" do
      it "should increment the counter when created" do
        expect {
          IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        }.to increment_counter_on(idea).for(IdeaAction)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        expect { idea_action.destroy }.to decrement_counter_on(idea).for(IdeaAction)
      end
    end
  end
end
