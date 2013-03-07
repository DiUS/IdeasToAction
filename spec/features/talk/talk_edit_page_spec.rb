describe "Talk edit page", js: true, acceptance: true do
  
  let(:talk) { Talk.first }
  let(:content_admin) { Member.find_by_role(Member::ROLE_CONTENT_ADMIN) }

  before do
    Capybara.reset_sessions!
    login(content_admin)
    talk.should_not be_nil
    visit "#/events/#{talk.event_id}/talks/edit/#{talk.id}"
  end

  it "should have the form to edit the talk" do
    page.should have_selector '#title'
    page.should have_selector '#description'
    page.should have_selector '#hero_image_url'
    page.should have_selector '#ted_talk_url'
  end

  it 'should have the fields pre-populated with the talk details' do
    page.find('#title').value.should eql talk.title
    page.find('#description').value.should eql talk.description
    page.find('#hero_image_url').value.should eql talk.hero_image_url
    page.find('#ted_talk_url').value.should eql talk.ted_talk_url
  end

  it 'should be able to change the details of the talk' do
    time = Time.now
    fill_in 'description', with: "changed on: #{time}"
    page.find('button[ng-click="update()"]').click
    visit "#/events/#{talk.event_id}/talks/edit/#{talk.id}"
    page.find('#description').value.should eql "changed on: #{time}"
  end
end