describe "Automatic member creation", js: true, acceptance: true do
  
  before :each do
    Capybara.reset_sessions!
    @member_ids_before = Member.all.map(&:id)
  end

  let(:heartbeat) { JSON.parse(page.text) }
  let(:member_id) { heartbeat["member_id"] }

  it "should have a member created" do
    visit '/heartbeat/beat.json'

    @member_ids_before.should_not include(member_id)
  end
end