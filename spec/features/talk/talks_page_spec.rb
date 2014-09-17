describe "Talks page", js: true, acceptance: true do
  before do
    visit "#/talks"
  end

  describe 'featured talk' do
    let (:featured_element){page.find('.content:first')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Featured Talk')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} ideas/
      featured_element_text.should match /\d{1,2} actions/
      featured_element_text.should match /\d{1,2} reactions/
    end
  end

  describe 'popular talks' do
    let(:featured_element){page.find('.content:nth-child(2)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Popular Talks')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} ideas/
      featured_element_text.should match /\d{1,2} actions/
      featured_element_text.should match /\d{1,2} reactions/
    end
  end

  describe 'recent talks' do
    let(:featured_element){page.find('.content:nth-child(3)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Recent Talks')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} ideas/
      featured_element_text.should match /\d{1,2} actions/
      featured_element_text.should match /\d{1,2} reactions/
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

    it 'should continue to allow user to load more talks'  do
      find("[text()='Load more talks']").should be_visible
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