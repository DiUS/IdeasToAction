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
    page.should have_selector '#featured'
  end

  it 'should have the fields pre-populated with the talk details' do
    page.find('#title').value.should eql talk.title
    page.find('#description').value.should eql talk.description
    page.find('#hero_image_url').value.should eql talk.hero_image_url
    page.find('#ted_talk_url').value.should eql talk.ted_talk_url
    page.find('#featured').checked?.should eql talk.featured
  end

  it 'should be able to change the details of the talk' do
    time = Time.now
    fill_in 'description', with: "changed on: #{time}"
    page.find('button[ng-click="update()"]').click
    visit "#/events/#{talk.event_id}/talks/edit/#{talk.id}"
    page.find('#description').value.should eql "changed on: #{time}"
  end

  context "Ideas collapsible" do
    let(:title) { "Ideas" }
    let(:item_contents) { talk.ideas.map(&:description) }

    it_should_behave_like "a collapsible"

    it 'should link to an edit idea page' do
      first = page.find(".collapsible[title='#{title}']").find('.item:first .description')
      first['ng-href'].should eql "/ideas/edit/#{talk.ideas.first.id}"
    end
  end
end