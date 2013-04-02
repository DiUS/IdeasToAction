require_relative 'collapsible_shared_examples'

describe "Member page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  before do
    Capybara.reset_sessions!
    visit '/heartbeat/beat.json'
  end

  let(:heartbeat) { JSON.parse(page.text) }
  let(:member_id) { heartbeat["member_id"] }
  let(:member) { Member.find(member_id) }

  before do
    member.should_not be_nil
    @interaction = Interaction.create! idea_action: IdeaAction.first, member: member, reaction_text: 'i think you have come up with something big here'
    member.interactions.size.should > 0
    visit "#/member"
  end

  after :each do
    member.destroy
    @interaction.destroy
  end

  it 'should display total number of actions done' do
    page.should have_content '1 Action Done'
  end

  context "My actions collapsible" do
    let(:title) { "My actions" }
    let(:starts_as_collapsed?) { false }
    let(:item_contents) { member.interactions.map(&:idea_action).map(&:description) }

    it_should_behave_like "a collapsible"
  end
end