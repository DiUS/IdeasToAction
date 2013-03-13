require_relative 'collapsible_shared_examples'

describe "Idea detail page", js: true, acceptance: true do
  
  let(:idea) { Idea.find(17) }
  let(:action) { idea.idea_actions.first }

  before :each do
    idea.should_not be_nil
    visit "#/ideas/17"
  end

  it "should have the idea details visible", :vcr do
    page.should have_content idea.description

    page.should have_content "Actions #{idea.idea_actions.size}"
  end

  context "Actions collapsible" do
    let(:title) { "Actions" }
    let(:item_contents) { idea.idea_actions.map(&:description) }

    it_should_behave_like "a collapsible"
  end

  context "Inspired by collapsible" do
    let(:title) { "Inspired by" }
    let(:item_contents) { idea.talks.map(&:title) }

    it_should_behave_like "a collapsible"
  end

  context "Reactions collapsible" do
    let(:title) { "Reactions" }
    let(:item_contents) { idea.reactions.map(&:text) }

    it_should_behave_like "a collapsible"
  end

  context "tags" do
    let(:tags) { idea.tags }

    it "should have each of the tags displayed", :vcr do
      tags.each do | tag | 
        page.should have_selector('.tag', text: tag.name)
      end
    end
  end

  context "share" do
    it 'should have a twitter share button', :vcr do
      page.should have_selector('.btn-twitter')
    end

    it 'should link to twitter', :vcr do
      page.find('.btn-twitter')[:href].should eql "https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Fwww.ideasintoaction.com&text=#{idea.talks.first.title}&tw_p=tweetbutton&url=#{idea.bitly_url}"
    end
  end

  describe 'when wanting to navigate back to the home page' do
    before do
      page.should_not have_selector('#home')
      page.first('.header .touch-icon').click
    end

    it 'should navigate back to home', :vcr do
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
    
    before :each do 
      self.use_transactional_fixtures.should be true

      idea.reload.reactions.size.should eq 2

      page.should_not have_selector('p.action-statement', text: 'You did on')
      reaction_collapsible.should have_selector('.header sup', text: '2')

      collapsible.find(".header").click
      page.should have_selector(".btn.done-it", visible: true)
      collapsible.find(".btn.done-it").click
    end

    it 'should display the date', :vcr do
      page.should have_selector('p.action-statement', text: 'You did on')
    end

    describe 'when reacting to an idea' do

      describe 'checking the number of reactions' do
        before :each do
          begin
            idea.reload.reactions.size.should eq 2
            reaction_collapsible.should have_selector('.header sup', text: '2')

            page.should have_selector(".reaction textarea")
            page.should have_selector(".reaction textarea", visible: true)

            page.find(".reaction textarea").set('This is my reaction')
            page.find(".reaction textarea").value.should eq 'This is my reaction'

            page.find('.submit-reaction').click
          rescue => e
            puts page.html
            raise e
          end
        end

        it 'should update the reactions', :vcr do
          reaction_collapsible.should have_selector('.header sup', text: '3')

          reaction_collapsible.find(".header").click
          reaction_collapsible.should have_text('This is my reaction')
        end
      end
    end
  end


end