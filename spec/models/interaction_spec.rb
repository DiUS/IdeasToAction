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
        expect { @interaction.update_attribute(:reaction_text, "My reaction") }.to increment_counter_on(@event).for("Reaction")
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect { Interaction.create!(:member => Member.first, :idea_action => @idea_action) }.not_to increment_counter_on(@event).for("Reaction")
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.update_attribute(:reaction_text, nil) }.to decrement_counter_on(@event).for("Reaction")
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.destroy }.to decrement_counter_on(@event).for("Reaction")
      end
    end

    describe "on talks" do
      it "should increment the counter when reaction text is entered" do
        expect { @interaction.update_attribute(:reaction_text, "My reaction") }.to increment_counter_on(@talk).for("Reaction")
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect { Interaction.create!(:member => Member.first, :idea_action => @idea_action) }.not_to increment_counter_on(@talk).for("Reaction")
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.update_attribute(:reaction_text, nil) }.to decrement_counter_on(@talk).for("Reaction")
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.destroy }.to decrement_counter_on(@talk).for("Reaction")
      end
    end

    describe "on ideas" do
      it "should increment the counter when reaction text is entered" do
        expect { @interaction.update_attribute(:reaction_text, "My reaction") }.to increment_counter_on(@idea).for("Reaction")
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect { Interaction.create!(:member => Member.first, :idea_action => @idea_action) }.not_to increment_counter_on(@idea).for("Reaction")
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.update_attribute(:reaction_text, nil) }.to decrement_counter_on(@idea).for("Reaction")
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.destroy }.to decrement_counter_on(@idea).for("Reaction")
      end
    end

    describe "on idea actions" do
      it "should increment the counter when reaction text is entered" do
        expect { @interaction.update_attribute(:reaction_text, "My reaction") }.to increment_counter_on(@idea_action).for("Reaction")
      end

      it "should not increment the counter when interaction is created with blank reaction text" do
        expect { Interaction.create!(:member => Member.first, :idea_action => @idea_action) }.not_to increment_counter_on(@idea_action).for("Reaction")
      end

      it "should decrement the counter when reaction text is removed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.update_attribute(:reaction_text, nil) }.to decrement_counter_on(@idea_action).for("Reaction")
      end

      it "should decrement the counter when interaction is destroyed" do
        @interaction.update_attribute(:reaction_text, "My reaction")
        expect { @interaction.destroy }.to decrement_counter_on(@idea_action).for("Reaction")
      end
    end
  end
end