require_relative 'collapsible_shared_examples'

describe "Talks & Events page", js: true, acceptance: true do
  
  describe 'Browsing' do
    let(:events) { Event.all }
    let(:talks) { Talk.all }

    before :each do
      visit "#/talks-events"
    end

    context "Talks collapsible" do
      let(:title) { "Talks" }
      let(:item_contents) { talks.map(&:title) }

      it_should_behave_like "a collapsible"
    end

    context "Events collapsible" do
      let(:title) { "Events" }
      let(:item_contents) { events.map(&:name) }

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

  describe "Searching" do
    before do
      visit "#/talks-events"
    end 

    it "should have a search text field" do
      page.should have_selector("#search-text", visible: true)
    end

    context "when typing a search query" do

      before :each do 
        fill_in "search-text", with: "body language"
      end

      it "should have results" do
        sleep 1
        page.should have_selector(".result", text: "Examine your own body language")
        page.should have_selector(".result", text: "Body language affects how others see us, but it may also change how we see ourselves.")
      end
    end
  end

end