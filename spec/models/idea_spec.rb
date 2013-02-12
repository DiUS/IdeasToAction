require 'spec_helper'

describe Idea do

  describe 'as_json' do
    let(:idea) { Idea.first }

    before do
      idea.should_receive(:members_actioned).and_return [1,2,3,4,5,6]
    end

    it 'should merge members_actioned_count into the json object' do
      idea.as_json[:members_actioned_count].should_not be_nil
    end

    it 'should set the members_actioned_count to the number of unique members who have actioned on the idea' do
      idea.as_json[:members_actioned_count].should == 6
    end
  end

  describe 'members_actioned' do
    let(:idea) { Idea.first }

    it 'should find unique members who have actioned on the current idea' do
      idea.send(:members_actioned).size.should == 3
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
end
