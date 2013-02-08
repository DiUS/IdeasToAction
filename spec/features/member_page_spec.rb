require_relative 'collapsible_shared_examples'

describe "Member page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  before :each do
    Capybara.reset_sessions!
    visit '/heartbeat/beat.json'
  end

  let(:heartbeat) { JSON.parse(page.text) }
  let(:member_id) { heartbeat["member_id"] }
  let(:member) { Member.find(member_id) }

  before :each do
    member.should_not be_nil
    @action_taken = ActionsTaken.create! action: Action.first, member: member
    member.actions.size.should > 0
    visit "/assets/index.html#/member"
  end 

  after :each do
    member.destroy
    @action_taken.destroy
  end

  it "should have the event page visible" do
    page.should have_content "Actions Taken #{member.actions.size}"
  end

  context "Actions collapsible" do
    let(:title) { "Actions Taken" }
    let(:item_contents) { member.actions.map(&:description) }

    it_should_behave_like "a collapsible"
  end

end