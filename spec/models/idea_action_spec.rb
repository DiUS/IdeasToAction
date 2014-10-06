require 'spec_helper'

describe IdeaAction do

	it { should be_accessible(:description) }
	it { should be_accessible(:featured) }
	it { should be_accessible(:idea) }
	it { should be_accessible(:idea_id) }
	it { should be_accessible(:member) }
	it { should be_accessible(:completion_date) }
	it { should be_accessible(:target_date) }

  it { should delegate(:description).to(:idea).with_prefix }
  it { should delegate(:email).to(:member).with_prefix }

  it { should validate_presence_of(:idea) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:target_date) }
	it { should belong_to(:member) }

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
		let(:member) { Member.first }

    describe "on events" do
      it "should increment the counter when created" do
        expect {
          IdeaAction.create!(idea_id: idea.id, description: 'test action', target_date: Time.now + 1.day, member: member)
        }.to increment_counter_on(event).for(IdeaAction)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(idea_id: idea.id, description: 'test action', target_date: Time.now + 1.day, member: member)
        expect { idea_action.destroy }.to decrement_counter_on(event).for(IdeaAction)
      end
    end

    describe "on talks" do
      it "should increment the counter when created" do
        expect {
          IdeaAction.create!(idea_id: idea.id, description: 'test action', target_date: Time.now + 1.day, member: member)
          talk.reload
        }.to increment_counter_on(talk).for(IdeaAction)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(idea_id: idea.id, description: 'test action', target_date: Time.now + 1.day, member: member)
        expect { idea_action.destroy }.to decrement_counter_on(talk).for(IdeaAction)
      end
    end

    describe "on ideas" do
      it "should increment the counter when created" do
        expect {
          IdeaAction.create!(idea_id: idea.id, description: 'test action', target_date: Time.now + 1.day, member: member)
        }.to increment_counter_on(idea).for(IdeaAction)
      end

      it "should decrement the counter when destroyed" do
        idea_action = IdeaAction.create!(idea_id: idea.id, description: 'test action', target_date: Time.now + 1.day, member: member)
        expect { idea_action.destroy }.to decrement_counter_on(idea).for(IdeaAction)
      end
		end

		describe 'completed?' do
			it 'should be true when completion date is present' do
				idea_action = IdeaAction.new(completion_date: Time.now)
				expect(idea_action.completed?).to be_true
			end

			it 'should be false when completion date is not set' do
				idea_action = IdeaAction.new
				expect(idea_action.completed?).to be_false
			end
		end

		describe 'completable?' do
			let(:member) { Member.new }
			let(:other_member) { Member.new }
			let(:idea_action) { IdeaAction.new(member: member) }

			it 'should be completable by the submitting member' do
				expect(idea_action.completable?(member)).to be_true
			end

			it 'should not be completable by other members' do
				expect(idea_action.completable?(other_member)).not_to be_true
			end

			it 'should not be completable when already completed' do
				idea_action.completion_date = Time.now
				expect(idea_action.completable?(member)).not_to be_true
			end
		end

		describe 'mine?' do
			let(:member) { Member.new }
			let(:other_member) { Member.new }
			let(:idea_action) { IdeaAction.new(member: member) }

			it 'should be "mine" for the submitting member' do
				expect(idea_action.mine?(member)).to be_true
			end

			it 'should not be "mine" to other members' do
				expect(idea_action.mine?(other_member)).not_to be_true
			end

			it 'should be "mine" when already completed' do
				idea_action.completion_date = Time.now
				expect(idea_action.mine?(member)).to be_true
			end
		end

		describe 'member_first' do
			let(:member) { Member.where(persistence_token: '9012').first }

			it 'should have members actions first' do
				idea_actions = IdeaAction.member_first member
				idea_actions[0...member.idea_actions.size].each do |idea_action|
					expect(member.idea_actions).to include(idea_action)
				end
			end
		end

		describe 'completed and uncompleted' do
			it 'should return only completed actions when requested' do
				idea_actions = IdeaAction.completed.limit(10)
				expect(idea_actions.size).to eq(idea_actions.select{ |idea_action| idea_action.completed? }.size)
			end

			it 'should return only uncompleted action when requested' do
				idea_actions = IdeaAction.incomplete.limit(10)
				expect(idea_actions.size).to eq(idea_actions.select{ |idea_action| !idea_action.completed? }.size)
			end
		end
	end
end
