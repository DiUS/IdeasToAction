describe "Talks page", js: true, acceptance: true do
  before do
    visit "#/talks"
  end

  describe 'featured talk' do
    let (:featured_element) { page.find('.content:first') }

    it 'should show' do
      featured_element.text.should_not be_empty
    end

    it 'should show total' do
      text = featured_element.text
      text.should match /\d{1,2} ideas/
      text.should match /\d{1,2} actions/
      text.should match /\d{1,2} reactions/
    end
  end

  describe 'other talks' do
    let (:other_elements) { page.all('.content:not(:first)') }

    it 'should show total' do
      other_elements.to_enum.with_index(0).each do | talk, index |
        text = other_elements[index].text
        break if text.include? 'More'
        text.should match /\d{1,2} ideas/
        text.should match /\d{1,2} actions/
        text.should match /\d{1,2} reactions/
      end
    end
  end

  describe 'more talks' do
    def wait_for_loading_symbol_to_disappear
      page.should_not have_selector('.extra-results-loading', visible: true)
    end

    before do
      new_talks = page.all('[ng-repeat="talk in extraTalks"]')
      new_talks.should be_empty

      find("[text()='Load more talks']").click()
      wait_for_loading_symbol_to_disappear()
    end

    it 'should render more talks on the page' do
      new_talks = page.all('[ng-repeat="talk in extraTalks"]')
      new_talks.should_not be_empty

      new_talks.to_enum.with_index(0).each do | talk, index |
        text = new_talks[index].text
        return if text.include? 'More'
        text.should match /\d{1,2} ideas/
        text.should match /\d{1,2} actions/
        text.should match /\d{1,2} reactions/
      end
    end

    it 'should no longer allow user to load more talks'  do
      find("[text()='Load more talks']").should_not be_visible
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