require 'spec_helper'

describe Interaction do
  it { should be_accessible(:idea_action) }
  it { should be_accessible(:idea_action_id) }
  it { should be_accessible(:member) }
  it { should be_accessible(:reaction_text) }
  it { should be_accessible(:member_id) }
  it { should belong_to(:member) }
  it { should belong_to(:idea_action) }
  it { should delegate(:description).to(:idea_action).with_prefix }

  let(:member) { Member.first }
  
  it "find all interactions by member" do
    new_interaction = Interaction.create! idea_action: IdeaAction.first, member: member, reaction_text: 'stuff'
    interactions = Interaction.find_by_member(member)

    interactions.size.should eql 2
    interactions.first.should eql Interaction.first
    interactions.last.should eql new_interaction
  end

  context "reactions counters" do
    before :each do
      @interaction = Interaction.new(:member => Member.first, :idea_action => IdeaAction.first)
      @interaction.save
      @idea_action = @interaction.idea_action
      @idea = @idea_action.idea
      @talk = @idea.talks.first
      @event = @talk.event
    end

    describe "on events" do
      it "should increment the counter when reaction text is entered" do
        prev_reactions_count = @event.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, "My reaction")
          @event.reload
        }.to change{ @event.reactions_count }.from(prev_reactions_count).to(prev_reactions_count+1)
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect {
          Interaction.create!(:member => Member.first, :idea_action => @idea_action)
          @event.reload
        }.not_to change{ @event.reactions_count }
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @event.reload.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, nil)
          @event.reload
        }.to change{ @event.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @event.reload.reactions_count
        expect {
          @interaction.destroy
          @event.reload
        }.to change{ @event.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end
    end

    describe "on talks" do
      it "should increment the counter when reaction text is entered" do
        prev_reactions_count = @talk.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, "My reaction")
          @talk.reload
        }.to change{ @talk.reactions_count }.from(prev_reactions_count).to(prev_reactions_count+1)
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect {
          Interaction.create!(:member => Member.first, :idea_action => @idea_action)
          @talk.reload
        }.not_to change{ @talk.reactions_count }
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @talk.reload.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, nil)
          @talk.reload
        }.to change{ @talk.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @talk.reload.reactions_count
        expect {
          @interaction.destroy
          @talk.reload
        }.to change{ @talk.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end
    end

    describe "on ideas" do
      it "should increment the counter when reaction text is entered" do
        prev_reactions_count = @idea.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, "My reaction")
          @idea.reload
        }.to change{ @idea.reactions_count }.from(prev_reactions_count).to(prev_reactions_count+1)
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect {
          Interaction.create!(:member => Member.first, :idea_action => @idea_action)
          @idea.reload
        }.not_to change{ @idea.reactions_count }
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @idea.reload.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, nil)
          @idea.reload
        }.to change{ @idea.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @idea.reload.reactions_count
        expect {
          @interaction.destroy
          @idea.reload
        }.to change{ @idea.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end
    end

    describe "on idea actions" do
      it "should increment the counter when reaction text is entered" do
        prev_reactions_count = @idea_action.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, "My reaction")
          @idea_action.reload
        }.to change{ @idea_action.reactions_count }.from(prev_reactions_count).to(prev_reactions_count+1)
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect {
          Interaction.create!(:member => Member.first, :idea_action => @idea_action)
          @idea_action.reload
        }.not_to change{ @idea_action.reactions_count }
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @idea_action.reload.reactions_count
        expect {
          @interaction.update_attribute(:reaction_text, nil)
          @idea_action.reload
        }.to change{ @idea_action.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        prev_reactions_count = @idea_action.reload.reactions_count
        expect {
          @interaction.destroy
          @idea_action.reload
        }.to change{ @idea_action.reactions_count}.from(prev_reactions_count).to(prev_reactions_count-1)
      end
    end
  end
end