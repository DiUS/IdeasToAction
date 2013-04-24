describe "Actions page", js: true, acceptance: true do
  before do
    visit "#/actions"
  end

  describe 'featured action' do
    let (:featured_element) { page.find('.content:first') }

    it 'should show' do
      featured_element.text.should_not be_empty
    end

    it 'should show total' do
      text = featured_element.text
      text.should match /\d{1,2} reactions/
    end
  end

  describe 'other actions' do
    let (:other_elements) { page.all('.content:not(:first)') }

    it 'should show total' do
      other_elements.to_enum.with_index(0).each do | action, index |
        text = other_elements[index].text
        break if text.include? 'More'
        text.should match /\d{1,2} reactions/
      end
    end
  end

  describe 'more actions' do
    def wait_for_loading_symbol_to_disappear
      page.should_not have_selector('.extra-results-loading', visible: true)
    end

    before do
      new_actions = page.all('[ng-repeat="action in extraActions"]')
      new_actions.should be_empty

      find("[text()='Load more actions']").click()
      wait_for_loading_symbol_to_disappear()
    end

    it 'should render more actions on the page' do
      new_actions = page.all('[ng-repeat="action in extraActions"]')
      new_actions.should_not be_empty

      new_actions.to_enum.with_index(0).each do | action, index |
        text = new_actions[index].text
        text.should match /\d{1,2} reactions/
      end
    end

    it 'should continue to allow user to load more actions'  do
      find("[text()='Load more actions']").should be_visible
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