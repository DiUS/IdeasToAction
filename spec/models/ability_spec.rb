require "cancan/matchers"

describe "abilities" do
  subject { ability }
  let(:ability) { Ability.new(member) }
  let(:member) { nil }

  context "when member is a content admin" do
    let(:member){ Member.find_by_role(Member::ROLE_CONTENT_ADMIN) }

    it { should be_able_to(:manage, Action.new) }
    it { should be_able_to(:manage, Event.new) }
    it { should be_able_to(:manage, Idea.new) }
    it { should be_able_to(:manage, Talk.new) }
    it { should be_able_to(:manage, member) }
    it { should_not be_able_to(:manage, Member.new) }
  end

  context "when member is a global admin" do
    let(:member){ Member.find_by_role(Member::ROLE_GLOBAL_ADMIN) }

    it { should be_able_to(:manage, Action.new) }
    it { should be_able_to(:manage, Event.new) }
    it { should be_able_to(:manage, Idea.new) }
    it { should be_able_to(:manage, Talk.new) }
    it { should be_able_to(:manage, Member.new) }
  end

  context "when member is a regular member" do
    let(:member){ Member.find_by_role(Member::ROLE_REGULAR) }

    it { should be_able_to(:ideas, Event.new) }
    it { should_not be_able_to(:manage, Event.new) }

    it { should be_able_to(:random, Action.new) }
    it { should be_able_to(:recent, Action) }
    it { should be_able_to(:doneIt, Action) }
    it { should_not be_able_to(:manage, Action) }

    it { should be_able_to(:random, Idea.new) }
    it { should be_able_to(:react, Idea.new) }
    it { should be_able_to(:create, Idea.new) }
    it { should_not be_able_to(:manage, Idea.new) }

    it { should_not be_able_to(:manage, Talk.new) }

    it { should be_able_to(:manage, member) }
    it { should_not be_able_to(:manage, Member.new) }
  end
end