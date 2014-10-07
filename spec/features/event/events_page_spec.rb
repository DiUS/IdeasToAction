describe "Events page", js: true, acceptance: true do
  before do
    visit "/#/events"
		sleep 1
  end

  describe 'featured event' do
    let(:featured_element){page.find('#events .content:first')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Featured Event')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} ideas/
      featured_element_text.should match /\d{1,2} actions/
    end
  end

  describe 'popular events' do
    let(:featured_element){page.find('#events .content:nth-child(2)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Popular Events')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} ideas/
      featured_element_text.should match /\d{1,2} actions/
    end
  end

  describe 'recent events' do
    let(:featured_element){page.find('#events .content:nth-child(3)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Recent Events')
    end

    it 'should show total' do
      featured_element_text.should match /\d{1,2} ideas/
      featured_element_text.should match /\d{1,2} actions/
    end
  end

  describe 'more events' do
    def wait_for_loading_symbol_to_disappear
      page.should_not have_selector('.extra-results-loading', visible: true)
    end

    before do
      new_events = page.all('[ng-repeat="event in extraEvents"]')
      new_events.should be_empty

      find("[text()='Load more events']").click()
      wait_for_loading_symbol_to_disappear()
    end

    it 'should render more events on the page' do
      new_events = page.all('[ng-repeat="event in extraEvents"]')
      new_events.should_not be_empty

      new_events.to_enum.with_index(0).each do | event, index |
        text = new_events[index].text
        text.should match /\d{1,2} ideas/
        text.should match /\d{1,2} actions/
      end
    end

    it 'should continue to allow user to load more events'  do
      find("[text()='Load more events']").should be_visible
    end
  end

  it 'should search' do
    find("#events input[type='text']").set("stuff")
    find('#events input.btn').click()
    sleep 1
    page.current_url.should match /#\/found\?query_text=stuff/
  end
end