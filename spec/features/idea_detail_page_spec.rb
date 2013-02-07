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

  shared_examples_for "a collapsible" do
    def collapsible
      page.find(".collapsible[title='#{title}']")
    end

    def items 
      collapsible.find(".items")
    end

    def header 
      collapsible.find(".header")
    end

    def items_should_be_visible(visible = true)
      collapsible.should have_selector('.items', visible: visible)
    end

    def items_should_not_be_visible
      items_should_be_visible(false)
    end

    it "should toggle the items when the header is clicked" do
      items.should_not be_visible
      header.click
      items_should_be_visible
      header.click
      items_should_not_be_visible
    end

    it "should have the items content" do
      item_contents.each do | item_content |
        items.should have_content item_content
      end
    end
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