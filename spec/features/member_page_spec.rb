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
    @interaction = Interaction.create! idea_action: IdeaAction.first, member: member, :reaction_text => 'thats bloody good'
    visit "#/member"
  end 

  after :each do
    member.destroy
    @interaction.destroy
  end

  it "should have the actions taken visible" do
    page.should have_content "Actions Taken #{member.idea_actions.size}"
  end

  it "should have the reactions visible" do
    page.should have_content "Reactions #{member.reactions.size}"
  end

  context "Actions collapsible" do
    let(:title) { "Actions Taken" }
    let(:item_contents) { member.idea_actions.map(&:description) }

    it_should_behave_like "a collapsible"
  end

  context "Reactions collapsible" do
    let(:title) { "Reactions" }
    let(:item_contents) { member.reactions.map(&:text) }

    it_should_behave_like "a collapsible"
  end

  describe 'when wanting to navigate back to the home page' do
    before do
      page.should_not have_selector('#home')
      page.first('.header .touch-icon').click
    end

    it 'should navigate back to home' do
      page.should have_selector('#home')
    end
  end

end