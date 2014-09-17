require_relative '../collapsible_shared_examples'

describe "Talk detail page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }
  let(:idea) { talk.ideas.first }

  before :each do
    talk.should_not be_nil
    visit "#/events/1/talks/1"
  end

  it "should have the talk details visible" do
    page.should have_content talk.title
    page.should have_content talk.description

    page.should have_content "Ideas#{talk.ideas.size}"
  end

  it 'should have an external link to the TED talk' do
    a = page.find("[text()='View this talk on TED.com']")
    a['phonegap-external'].should eql talk.ted_talk_url
  end

  context "Ideas collapsible" do
    let(:title){"Ideas"}
    let(:item_contents){talk.ideas.map(&:description)}
    let(:ideas_header){page.find(".collapsible[title='#{title}']").find(".content-header")}

    it_should_behave_like "a collapsible"

    it "should have a 'Submit a new idea' button" do
      page.should have_selector("[text()='Submit a new idea']")
    end

    context "when clicking the 'Submit a new idea' button..." do
      let(:new_idea_button) { page.find("[text()='Submit a new idea']") }

      before :each do
        ideas_header.click
        new_idea_button.click
      end

      it "should show the submission form" do
        page.should have_selector("#new-idea-dialog", visible: true)
      end

    end
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