require_relative 'collapsible_shared_examples'

describe "Idea detail page", js: true, acceptance: true do
  
  let(:idea) { Idea.find(1) }
  let(:action) { idea.actions.first }

  before :each do
    idea.should_not be_nil
    visit "/assets/index.html#/ideas/#{idea.id}"
  end

  it "should have the idea details visible" do
    page.should have_content idea.body

    page.should have_content "Actions #{idea.actions.size}"
  end

  context "Actions collapsible" do
    let(:title) { "Actions" }
    let(:item_contents) { idea.actions.map(&:description) }

    it_should_behave_like "a collapsible"
  end

  context "Reactions collapsible" do
    let(:title) { "Reactions" }
    let(:item_contents) { idea.reactions.map(&:text) }

    it_should_behave_like "a collapsible"
  end

end