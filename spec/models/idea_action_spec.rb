require 'spec_helper'

describe IdeaAction do
  it { should delegate(:description).to(:idea).with_prefix }
  it { should validate_presence_of(:idea) }
  it { should validate_presence_of(:description) }

  describe "scoping" do
    it "should return featured idea actions" do
      idea_actions = IdeaAction.featured
      idea_actions.each{ |idea_action| idea_action.featured?.should be_true }
    end

    it 'should return recent idea actions' do
      idea_actions = IdeaAction.recent
      idea_actions.should include(IdeaAction.order("created_at desc").first)
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
