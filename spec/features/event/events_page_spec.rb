describe "Events page", js: true, acceptance: true do
  before do
    visit "#/events"
  end

  describe 'featured event' do
    let (:featured_element) { page.find('.content:first') }

    it 'should show' do
      featured_element.should have_selector 'img'
    end

    it 'should show total' do
      featured_element.should have_content 'ideas'
      featured_element.should have_content 'actions'
      featured_element.should have_content 'reactions'
    end
  end

  describe 'other events' do
    let (:other_elements) { page.all('.content:not(:first)') }

    it 'should show total' do
      other_elements.to_enum.with_index(0).each do | event, index |
        other_elements[index].should have_content 'ideas'
        other_elements[index].should have_content 'actions'
        other_elements[index].should have_content 'reactions'
      end
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