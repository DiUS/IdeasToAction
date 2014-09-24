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
    visit "#/member"
  end

  after :each do
    member.destroy
  end
end