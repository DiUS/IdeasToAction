require_relative '../escape_patch_shared_examples'

describe "Actions page", js: true, acceptance: true do
  before do
    visit "/#/actions"
  end

  describe 'featured action' do
    let(:featured_element){page.find('#actions .content:first')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Featured Action')
    end
  end

  describe 'recent actions' do
    let(:featured_element){page.find('#actions .content:nth-child(2)')}
    let(:featured_element_text){featured_element.text}

    it 'should have title' do
      featured_element_text.should have_content('Recent Actions')
    end
  end

  describe 'more actions' do
    def wait_for_loading_symbol_to_disappear
      page.should_not have_selector('#actions .extra-results-loading', visible: true)
    end

    before do
      new_actions = page.all("[ng-repeat='action in extraActions|unique: \"id\"']")
      new_actions.should be_empty

      find("[text()='Load more actions']").click()
      wait_for_loading_symbol_to_disappear()
    end

    it 'should render more actions on the page' do
      new_actions = page.all("[ng-repeat='action in extraActions|unique: \"id\"']")
      new_actions.should_not be_empty
    end

    it 'should continue to allow user to load more actions'  do
      find("[text()='Load more actions']").should be_visible
    end
  end

  it 'should search' do
    find("#actions input[type='text']").set("stuff")
    find('#actions input.btn').click()
    sleep 1
    page.current_url.should match /#\/found\?query_text=stuff/
	end

	it_should_behave_like 'a page with escape patch back home'
end
