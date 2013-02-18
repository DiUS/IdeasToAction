require_relative 'collapsible_shared_examples'

describe "Idea detail page", js: true, acceptance: true do
  
  let(:idea) { Idea.find(1) }
  let(:action) { idea.actions.first }

  before :each do
    idea.should_not be_nil
    visit "/assets/index.html#/ideas/1"
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

  context "tags" do
    let(:tags) { idea.tags }

    it "should have each of the tags displayed" do
      tags.each do | tag | 
        page.should have_selector('.tag', text: tag.name)
      end
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
      Rails.logger.info "STARTING NEW DESCRIBE FOREACH"
      self.use_transactional_fixtures.should be true

      Rails.logger.info "ASSERTING ON NUMBER OF REACTIONS"
      idea.reload.reactions.size.should eq 5

      page.should_not have_selector('p.action-statement', text: 'You did on')
      reaction_collapsible.should have_selector('.header sup', text: '5')

      Rails.logger.info "--- Marking action as done"
      collapsible.find(".header").click
      page.should have_selector(".btn.done-it", visible: true)
      collapsible.find(".btn.done-it").click
    end

    it 'should display the date' do
      page.should have_selector('p.action-statement', text: 'You did on')
    end

    describe 'when reacting to an idea' do

      describe 'checking the number of reactions' do
        before :each do
          begin
            idea.reload.reactions.size.should eq 5
            reaction_collapsible.should have_selector('.header sup', text: '5')

            page.should have_selector('p.action-statement', text: 'You did on')

            page.should have_selector(".reaction textarea")
            page.should have_selector(".reaction textarea", visible: true)

            page.find(".reaction textarea").set('This is my reaction')
            page.find(".reaction textarea").value.should eq 'This is my reaction'

            Rails.logger.info "--------- About to submit reaction"
            page.find('.submit-reaction').click
          rescue => e
            puts page.html
            raise e
          end
        end

        it 'should update the reactions' do
          reaction_collapsible.should have_selector('.header sup', text: '6')

          reaction_collapsible.find(".header").click
          reaction_collapsible.should have_text('This is my reaction')
        end
      end
    end
  end


end