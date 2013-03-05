require_relative '../collapsible_shared_examples'

describe "Event detail page", js: true, acceptance: true do
  
  let(:event) { Event.find(1) }

  before :each do
    event.should_not be_nil
    visit "#/events/#{event.id}"
  end

  it "should have the event page visible" do
    page.should have_content event.name

    page.should have_content "Talks #{event.talks.size}"
    page.should have_content "Ideas #{event.ideas.size}"
  end

  context "Talks collapsible" do
    let(:title) { "Talks" }
    let(:item_contents) { event.talks.map(&:title) }

    it_should_behave_like "a collapsible"
  end

  context "Ideas collapsible" do
    let(:title) { "Ideas" }
    let(:item_contents) { event.ideas.map(&:description) }

    it_should_behave_like "a collapsible"
  end

  describe 'when wanting to navigate back to the home page' do
    before do
      page.should_not have_selector('#home')
      page.find('.header .home-page').click
    end

    it 'should navigate back to home' do
      page.should have_selector('#home')
    end
  end

end