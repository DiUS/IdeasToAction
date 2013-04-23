describe "Ideas page", js: true, acceptance: true do
  before do
    visit "#/ideas"
  end

  describe 'featured idea' do
    let (:featured_element) { page.find('.content:first') }

    it 'should show' do
      featured_element.text.should_not be_empty
    end

    it 'should show total' do
      text = featured_element.text
      text.should match /\d{1,2} actions/
      text.should match /\d{1,2} reactions/
    end
  end

  describe 'other ideas' do
    let (:other_elements) { page.all('.content:not(:first)') }

    it 'should show total' do
      other_elements.to_enum.with_index(0).each do | idea, index |
        text = other_elements[index].text
        break if text.include? 'More'
        text.should match /\d{1,2} actions/
        text.should match /\d{1,2} reactions/
      end
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
      new_ideas = page.all('[ng-repeat="idea in extraIdeas"]')
      new_ideas.should_not be_empty

      new_ideas.to_enum.with_index(0).each do | idea, index |
        text = new_ideas[index].text
        text.should match /\d{1,2} actions/
        text.should match /\d{1,2} reactions/
      end
    end

    it 'should continue to allow user to load more ideas'  do
      find("[text()='Load more ideas']").should be_visible
    end
  end

  it 'should search' do
    find("input[type='text']").set("stuff")
    find('input.btn').click()
    sleep 1
    page.current_url.should match /#\/found\?query_text=stuff/
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