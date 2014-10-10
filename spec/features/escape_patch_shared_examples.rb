shared_examples_for 'a page with escape patch back home' do
	before do
		page.should_not have_selector('#home')
		page.first('.header .touch-icon').click
	end

	it 'should navigate back to home' do
		page.should have_selector('#home')
	end
end