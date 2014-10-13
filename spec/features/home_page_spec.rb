describe "Home page", js: true do
  self.use_transactional_fixtures = false

  before do
    visit "/#/home"
  end 

  it "should display welcome text that rattles the bones" do
    page.text.should =~ /(\d+) Ideas/
    page.text.should =~ /(\d+) Talks/
    page.text.should =~ /(\d+) Events/
    page.text.should =~ /Start something TEDxUltimo; the ultimate place to start something/
  end

  it 'should link to ideas' do
    page.should have_selector('[ng-href="/ideas"]')
  end

  it 'should link to talks' do
    page.should have_selector('[ng-href="/talks"]')
  end

  it 'should link to events' do
    page.should have_selector('[ng-href="/events"]')
  end

  it 'should search' do
    find("input[type='text']").set("stuff")
    find('input.btn').click()
    sleep 1
    page.current_url.should match /#\/found\?query_text=stuff/
	end

	describe 'pluralization' do
		context 'of events' do
			it 'should be singular when 1 event' do
				Event.stub(:size).and_return(1)

				visit '/#/home'
				expect(page).to have_content('Event')
				expect(page).not_to have_content('Events')
			end

			it 'should be plural when 10 events' do
				Event.stub(:size).and_return(10)

				visit '/#/home'
				expect(page).to have_content('Events')
			end
		end

		context 'of talks' do
			it 'should be singular when 1 talk' do
				Talk.stub(:size).and_return(1)

				visit '/#/home'
				expect(page).to have_content('Talk')
				expect(page).not_to have_content('Talks')
			end

			it 'should be plural when 10 talks' do
				Talk.stub(:size).and_return(10)

				visit '/#/home'
				expect(page).to have_content('Talk')
			end
		end

		context 'of ideas' do
			it 'should should be singular when 1 idea' do
				Idea.stub(:size).and_return(1)

				visit '/#/home'
				expect(page).to have_content('Idea')
				expect(page).not_to have_content('Ideas')
			end

			it 'should be plural when 10 ideas' do
				Idea.stub(:size).and_return(1)

				visit '/#/home'
				expect(page).to have_content('Ideas')
			end
		end
	end
end
