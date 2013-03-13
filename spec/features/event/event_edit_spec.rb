require_relative '../collapsible_shared_examples'

describe "Event edit page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  let(:event) { Event.find_by_name('TEDActive') }
  let(:content_admin) { Member.find_by_role(Member::ROLE_CONTENT_ADMIN)}

  describe 'listing all events to edit' do
    before do
      event.should_not be_nil
      visit "#/events/edit"
    end

    context "Events collapsible" do
      let(:title) { "Events" }
      let(:item_contents) { Event.all.map(&:name) }

      it_should_behave_like "a collapsible"

      it 'should link to an edit event page' do
        first = page.find(".collapsible[title='#{title}']").find('.item:first .description')
        first['ng-href'].should eql '/events/edit/1'
      end
    end
  end

  describe 'editing a specific event' do

    before do
      Capybara.reset_sessions!
      login(content_admin)
      event.should_not be_nil
      visit "#/events/edit/#{event.id}"
    end

    it "should have the form to edit the event" do
      page.should have_selector '#name'
      page.should have_selector '#description'
      page.should have_selector '#logo_image_url'
      page.should have_selector '#hero_image_url'
    end

    it 'should have the fields pre-populated with the event details' do
      page.find('#name').value.should eql event.name
      page.find('#description').value.should eql event.description
      page.find('#logo_image_url').value.should eql event.logo_image_url
      page.find('#hero_image_url').value.should eql event.hero_image_url
    end

    it 'should be able to change the details of the event' do
      time = Time.now
      fill_in 'description', with: "changed on: #{time}"
      page.find('button[ng-click="update()"]').click
      visit "#/events/edit/#{event.id}"
      page.find('#description').value.should eql "changed on: #{time}"
    end

    it 'should be able to add a talk' do
      button = page.find('button', text: 'Add a Talk')
      button.should_not be_nil
      button['ng-href'].should eql "/events/#{event.id}/talks/new"
    end

    context "Talks collapsible" do
      let(:title) { "Talks" }
      let(:item_contents) { event.talks.map(&:title) }

      it_should_behave_like "a collapsible"

      it 'should link to an edit talk page' do
        first = page.find(".collapsible[title='#{title}']").find('.item:first .description')
        first['ng-href'].should eql "/events/#{event.id}/talks/edit/#{event.talks.first.id}"
      end
    end
  end
end