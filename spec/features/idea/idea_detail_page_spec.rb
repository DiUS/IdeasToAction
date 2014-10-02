require_relative '../collapsible_shared_examples'
require 'open-uri'

describe "Idea detail page", js: true, acceptance: true do
  self.use_transactional_fixtures = false
  
  let(:idea) { Idea.find(1) }
  let(:action) { idea.idea_actions.first }

  before :each do
		ApplicationController.any_instance.stub(:current_member).and_return(action.member)
    DatabaseCleaner.start
    idea.should_not be_nil
    visit "#/ideas/1"
  end

  after :each do
    DatabaseCleaner.clean
  end

  it "should have the idea details visible" do
    page.should have_content idea.description

    page.should have_content "Actions#{idea.idea_actions.size}"
  end

  context "Actions collapsible" do
    let(:title) { "Actions" }
    let(:item_contents) { idea.idea_actions.map(&:description) }

    it_should_behave_like "a collapsible"
  end

  context "Inspired by collapsible" do
    let(:title) { "Inspired by" }
    let(:starts_as_collapsed?) { false }
    let(:item_contents) { idea.talks.map(&:title) }

    it_should_behave_like "a collapsible"
  end

  context "share" do
    it 'should have a twitter share button' do
      page.should have_selector('.btn-twitter')
    end

    it 'should link to twitter' do
      page.find('.btn-twitter:first')['phonegap-external'].should match /https:\/\/twitter.com\/intent\/tweet\?original_referer=&text=.*&tw_p=tweetbutton&url=.*/
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

  describe 'when taking action on an idea' do
    def collapsible
      page.find(".collapsible[title='Actions']")
    end
    
    before do
      collapsible.find('.content-header').click
      expect(page).to have_selector('.btn.done-it', visible: true)
      collapsible.find('.content-item:first-child .btn.done-it').click
		end

		it 'should display the completion date' do
			expect(page).to have_content("Completed on #{Time.now.strftime('%d/%m/%Y')}")
		end
  end
end