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

  describe 'when taking action on an idea' do
    let(:collapsible) { page.find(".collapsible[title='Actions']") }
    
    before :each do 
      page.should_not have_content 'You did on'
      collapsible.find(".header").click
      collapsible.find(".btn").click
    end

    it 'should display the date' do
      page.should have_content 'You did on'
    end
  end

  describe 'when reacting to an idea' do
    let(:collapsible) { page.find(".collapsible[title='Reactions']") }

    before :each do
      collapsible.should have_selector('.header sup', text: '5')
      page.find('#reaction').set('This is my reaction')
      page.find('#submit-reaction').click
    end

    it 'should update the count on the reaction collapsible' do
      collapsible.should have_selector('.header sup', text: '6')
    end
  end
end