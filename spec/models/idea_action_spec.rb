require 'spec_helper'

describe IdeaAction do

	it { should be_accessible(:description) }
	it { should be_accessible(:featured) }
	it { should be_accessible(:idea) }
	it { should be_accessible(:idea_id) }
	it { should be_accessible(:member) }
	it { should be_accessible(:completion_date) }
	it { should be_accessible(:target_date) }
  it {should be_accessible(:reminded)}

  it { should delegate(:description).to(:idea).with_prefix }
  it { should delegate(:email).to(:member).with_prefix }

  it { should validate_presence_of(:idea) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:target_date) }
	it { should belong_to(:member) }

  describe "scopes" do
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

		# describe 'member_first' do
		# 	let(:member) { Member.where(persistence_token: '9012').first }
		#
		# 	it 'should have members actions first' do
		# 		idea_actions = IdeaAction.member_first member
		# 		idea_actions[0...member.idea_actions.size].each do |idea_action|
		# 			expect(member.idea_actions).to include(idea_action)
		# 		end
		# 	end
		# end

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

  describe "booleans" do
    describe "complete?" do
      it 'should be true when completion date is present' do
        idea_action = IdeaAction.new(completion_date: Time.now)
        expect(idea_action.complete?).to be_true
      end

      it 'should be false when completion date is not set' do
        idea_action = IdeaAction.new
        expect(idea_action.complete?).to be_false
      end
    end

    describe "incomplete?" do
      it 'should be false when completion date is present' do
        idea_action = IdeaAction.new(completion_date: Time.now)
        expect(idea_action.incomplete?).to eq false
      end

      it 'should be true when completion date is not set' do
        idea_action = IdeaAction.new
        expect(idea_action.incomplete?).to eq true
      end
    end

    describe "completable?" do
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

    describe "mine?" do
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

    describe "due_soon?" do
      let(:member){Member.new}
      let(:idea_action){IdeaAction.new(target_date: Time.now)}

      describe "before due" do
        it "is not due soon" do
          Timecop.travel(idea_action.target_date - 8.days) do
            expect(idea_action.due_soon?).to eq false
          end
        end
      end

      describe "when due" do
        it "is due soon" do
          Timecop.travel(idea_action.target_date + 1.day) do
            expect(idea_action.due_soon?).to eq true
          end
        end
      end
    end

    describe "reminded?" do
      subject{IdeaAction.new}

      it "should be false by default" do
        expect(subject.reminded?).to eq false
      end

      it "should be true after updating" do
        subject.reminded = true
        expect(subject.reminded?).to eq true
      end
    end

    describe "remindable?" do
      describe "is remindable" do
        subject{IdeaAction.new(target_date: 6.days.from_now)}

        it "is indeed" do
          expect(subject.remindable?).to eq true
        end
      end

      describe "is not remindable because it is not yet due" do
        subject{IdeaAction.new(target_date: 8.days.from_now)}

        it "is indeed" do
          expect(subject.remindable?).to eq false
        end
      end

      describe "is not remindable because it has already been reminded" do
        subject{IdeaAction.new(target_date: 6.days.from_now, reminded: true)}

        it "is indeed" do
          expect(subject.remindable?).to eq false
        end
      end
    end
  end

  describe "collection methods" do
    let(:idea_action1){double(IdeaAction, id: 1, description: 'description1', target_date: 8.days.from_now)}
    let(:idea_action2){double(IdeaAction, id: 2, description: 'description2', target_date: 6.days.from_now)}
    let(:idea_actions){[idea_action1, idea_action2]}

    describe "self.descriptions" do
      before do
        IdeaAction.should_receive(:all).and_return(idea_actions)
      end

      it "should work" do
        expect(IdeaAction.descriptions).to eq [["(1) description1", 1], ["(2) description2", 2]]
      end
    end

    describe "self.incomplete" do
      it "should work" do
        expect(IdeaAction.incomplete.all?{|ia| ia.incomplete?}).to eq true
      end
    end

    describe "self.due_soon" do
      it "should work" do
        expect(IdeaAction.due_soon.all?{|ia| ia.due_soon?}).to eq true
      end
    end

    describe "self.unreminded" do
      it "should work" do
        expect(IdeaAction.unreminded.all?{|ia| ia.unreminded?}).to eq true
      end
    end

    describe "self.remindable" do
      it "should work for all idea actions" do
        expect(IdeaAction.remindable.all? do |idea_action|
          idea_action.incomplete? &&
          idea_action.due_soon? &&
          idea_action.unreminded?
        end).to eq true
      end

      describe "self.remindable for one member" do
        it "should work for one member's idea actions" do
          member = Member.first
          expect(IdeaAction.remindable(member).all? do |idea_action|
            idea_action.incomplete? &&
            idea_action.due_soon? &&
            idea_action.unreminded? &&
            idea_action.member_id == member.id
          end).to eq true
        end
      end
    end

    describe "self.bulk_set_reminded" do
      it "should update multiple idea actions as reminded" do
        expect(IdeaAction.bulk_set_reminded(IdeaAction.unreminded.first(2)).all?{|ia| ia.reminded?}).to eq true
      end
    end

    describe "self.reminded" do
      it "should work" do
        expect(IdeaAction.reminded.all?{|ia| ia.reminded?}).to eq true
      end
    end

    describe "self.viewable" do
      let(:event){Event.create!(name: 'event name', description: 'event description', hero_image_url: 'http://hero.image.url.com')}
      let(:member){Member.create!(email: 'member@example.com')}
      let(:talk){Talk.create!(event: event, title: 'talk title', description: 'talk description', viewable: true)}
      let(:idea){Idea.create(member: member, description: 'idea description', talks: [talk])}
      let(:talk_to_idea_association){TalkToIdeaAssociation.create!(idea: idea, talk: talk)}
      let(:idea_action){IdeaAction.create!(idea: idea, description: 'idea_action description', target_date: 6.days.from_now, member: member)}

      it 'should work' do
        expect(IdeaAction.viewable).to include(idea_action)
      end
    end

    describe "self.total" do
      it "should work" do
        expect(IdeaAction.viewable.count).to eq 31
      end
    end
  end

end
