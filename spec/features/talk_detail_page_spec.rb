require_relative 'collapsible_shared_examples'

describe "Talk detail page", js: true, acceptance: true do
  
  let(:talk) { Talk.find(1) }
  let(:idea) { talk.ideas.first }

  before :each do
    talk.should_not be_nil
    visit "/assets/index.html#/events/1/talks/1"
  end

  it "should have the talk details visible" do
    page.should have_content talk.title
    page.should have_content talk.description

    page.should have_content "Ideas #{talk.ideas.size}"
  end

  context "Ideas collapsible" do
    let(:title) { "Ideas" }
    let(:item_contents) { talk.ideas.map(&:body) }

    it_should_behave_like "a collapsible"

    it "should have a 'Submit a new idea' button" do
      page.should have_selector('#new-idea', text: 'Submit a new idea')
    end

    context "when clicking the 'Submit a new idea' button..." do
      let(:new_idea_button) { page.find('#new-idea', text: 'Submit a new idea') }

      before :each do
        new_idea_button.click
      end

      it "should show the submission form" do
        page.should have_selector("#new-idea-dialog", visible: true)
      end

    end
  end

end