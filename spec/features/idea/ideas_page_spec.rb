describe "Ideas page", js: true, acceptance: true do
  before do
    visit "/#/ideas"
  end

  describe 'featured idea' do
    let(:featured_element){page.find('#ideas .content:first')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Featured Idea')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} actions/
    end
  end

  describe 'popular ideas' do
    let(:featured_element){page.find('#ideas .content:nth-child(2)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Popular Ideas')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} actions/
    end
  end

  describe 'recent ideas' do
    let(:featured_element){page.find('#ideas .content:nth-child(3)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Recent Ideas')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} actions/
    end
  end

  describe 'more ideas' do
    def wait_for_loading_symbol_to_disappear
      page.should_not have_selector('.extra-results-loading', visible: true)
    end

    before do
      new_ideas = page.all('[ng-repeat="idea in extraIdeas"]')
      new_ideas.should be_empty

      find("[text()='Load more ideas']").click()
      wait_for_loading_symbol_to_disappear()
    end

    it 'should render more ideas on the page' do
      new_ideas = page.all("[ng-repeat='idea in extraIdeas|unique: \"id\"']")
      new_ideas.should_not be_empty

      new_ideas.to_enum.with_index(0).each do | idea, index |
        text = new_ideas[index].text
        text.should match /\d{1,2} actions/
      end
    end

    it 'should continue to allow user to load more ideas'  do
      find("[text()='Load more ideas']").should be_visible
    end
  end

  it 'should search' do
    find("#ideas form[name='searchQuery'] input[type='text']").set("stuff")
    find('#ideas input.btn').click()
    sleep 1
    page.current_url.should match /#\/found\?query_text=stuff/
  end
end