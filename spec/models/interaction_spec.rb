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
end