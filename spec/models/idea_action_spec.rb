require 'spec_helper'

describe IdeaAction do
  it { should delegate(:description).to(:idea).with_prefix }

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

  describe "featured only" do
    let(:featured_idea_actions) { IdeaAction.featured_only }

    it "should scope featured idea actions" do
      featured_idea_actions.each do |idea_action|
        idea_action.featured.should be_true
      end
    end
  end

  describe "counters" do
    let(:event) { Event.first }
    let(:talk) { event.talks.first }
    let(:idea) { talk.ideas.first }

    describe "on events" do
      it "should increment the counter when created" do
        prev_idea_actions_count = event.idea_actions_count
        expect {
          IdeaAction.create!(:idea_id => idea.id, :description => "test action")
          event.reload # model needs to get reloaded since counter_cache is getting updated in the database directly
        }.to change{ event.idea_actions_count }.from(prev_idea_actions_count).to(prev_idea_actions_count+1)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        prev_idea_actions_count = event.reload.idea_actions_count
        expect {
          idea_action.destroy
          event.reload
        }.to change{ event.idea_actions_count }.from(prev_idea_actions_count).to(prev_idea_actions_count-1)
      end
    end

    describe "on talks" do
      it "should increment the counter when created" do
        prev_idea_actions_count = talk.idea_actions_count
        expect {
          IdeaAction.create!(:idea_id => idea.id, :description => "test action")
          talk.reload
        }.to change{ talk.idea_actions_count }.from(prev_idea_actions_count).to(prev_idea_actions_count+1)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        prev_idea_actions_count = talk.reload.idea_actions_count
        expect {
          idea_action.destroy
          talk.reload
        }.to change{ talk.idea_actions_count }.from(prev_idea_actions_count).to(prev_idea_actions_count-1)
      end
    end

    describe "on ideas" do
      it "should increment the counter when created" do
        prev_idea_actions_count = idea.idea_actions_count
        expect {
          IdeaAction.create!(:idea_id => idea.id, :description => "test action")
          idea.reload
        }.to change { idea.idea_actions_count }.from(prev_idea_actions_count).to(prev_idea_actions_count+1)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(:idea_id => idea.id, :description => "test action")
        prev_idea_actions_count = idea.reload.idea_actions_count
        expect {
          idea_action.destroy
          idea.reload
        }.to change { idea.idea_actions_count }.from(prev_idea_actions_count).to(prev_idea_actions_count-1)
      end
    end
  end
end
