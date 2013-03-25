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
end