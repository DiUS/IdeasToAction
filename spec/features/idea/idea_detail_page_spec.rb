require_relative '../collapsible_shared_examples'
require 'open-uri'

describe "Idea detail page", js: true, acceptance: true do
  self.use_transactional_fixtures = false
  
  let(:idea) { Idea.find(1) }
  let(:action) { idea.idea_actions.first }

  before :each do
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

  context "Reactions collapsible" do
    let(:title) { "Reactions" }
    let(:item_contents) { idea.interactions.map(&:reaction_text) }

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

    def reaction_collapsible
      page.find(".collapsible[title='Reactions']")
    end
    
    before do
      reaction_collapsible.should have_selector('.content-header sup', text: '3')

      collapsible.find(".content-header").click
      page.should have_selector(".btn.done-it", visible: true)
      collapsible.find(".content-item:first-child .btn.done-it").click
      sleep 1
    end

    it 'should display the date' do
      collapsible.should have_selector('.content-item .tile', text: 'You did on')
    end

    describe 'when reacting to an idea' do

      describe 'checking the number of reactions' do
        before :each do
          begin
            reaction_collapsible.should have_selector('.content-header sup', text: '3')

            collapsible.should have_selector(".content-item:first-child .reaction textarea")
            collapsible.should have_selector(".content-item:first-child .reaction textarea", visible: true)

            collapsible.find(".content-item:first-child .reaction textarea").set('This is my reaction')
            collapsible.find(".content-item:first-child .reaction textarea").value.should eq 'This is my reaction'

            collapsible.find('.content-item:first-child .btn.submit-reaction').click
          rescue => e
            puts page.html
            raise e
          end
        end

        it 'should update the reactions' do
          reaction_collapsible.should have_selector('.content-header sup', text: '4')

          reaction_collapsible.find(".content-header").click
          reaction_collapsible.should have_text('This is my reaction')
        end
      end
    end
  end
end