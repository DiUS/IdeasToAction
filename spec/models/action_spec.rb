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
    before do
      @action = Action.first
    end

    it 'should find unique members who have actioned' do
      @action.send(:members_actioned).size.should == 3
    end
  end
end
