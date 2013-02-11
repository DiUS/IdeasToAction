require 'spec_helper'

describe Action do
  describe 'as_json' do
    before do
      @action = Action.first
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
    let(:action) { Action.first }

    it 'should find unique members who have actioned' do
      action.send(:members_actioned).size.should == 3
    end
  end

  describe 'actions_taken.from_member' do
    let(:member) { Member.first }
    let(:action) { Action.first }
    let(:member_action_taken) { ActionsTaken.first }

    it 'should find a single action taken from a member' do
      action.actions_taken.from_member(member).should eql member_action_taken
    end    
  end
end
