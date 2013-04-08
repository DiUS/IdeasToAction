require 'spec_helper'

describe Idea do

  it { should be_accessible(:tags) }
  it { should be_accessible(:talks) }
  it { should be_accessible(:description) }
  it { should be_accessible(:idea_actions) }
  it { should be_accessible(:interactions) }
  it { should be_accessible(:featured) }
  it { should be_accessible(:member_id) }
  it { should be_accessible(:talk_ids) }

  it { should delegate(:username).to(:member).with_prefix }

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

  describe "#member" do
    let(:idea) { Idea.first }
    let(:member) { Member.first }

    it "should belong to a member" do
      idea.member = member
      idea.save!
      idea.reload
      idea.member.should eq member
    end

    it "should be required" do
      idea.should be_valid
      idea.member = nil
      idea.should_not be_valid
    end
  end

  describe "#talks" do
    let(:idea) { Idea.first }

    it { should have_many(:talks).through(:talk_to_idea_associations) }

    it "should require at least one" do
      idea.should be_valid
      idea.talks = []
      idea.should_not be_valid
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

  describe "featured only" do
    let(:featured_ideas) { Idea.featured_only }

    it "should scope featured ideas" do
      featured_ideas.each do |idea|
        idea.featured.should be_true
      end
    end
  end

  describe "counter on events" do
    let (:event) { Event.first }
    let (:talk) { event.talks.first }

    it "should increment the counter on events when created" do
      prev_ideas_count = event.ideas_count
      expect {
        Idea.create!(:talks => [talk], :member_id => Member.first.id, :description => "test idea")
        event.reload # model needs to get reloaded since counter_cache is getting updated in the database directly
      }.to change{ event.ideas_count }.from(prev_ideas_count).to(prev_ideas_count+1)
    end

    it "should decrement the counter on events when destroyed" do
      idea = Idea.create!(:talks => [talk], :member_id => Member.first.id, :description => "test idea")
      prev_ideas_count = event.reload.ideas_count
      expect {
        idea.destroy
        event.reload
      }.to change{ event.ideas_count }.from(prev_ideas_count).to(prev_ideas_count-1)
    end
  end
end
