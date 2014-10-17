describe 'Instructions page', js: true, acceptance: true do
  before do
    visit '/#/instructions'
  end

  describe 'page content' do
    it 'should have a thanks message' do
      expect(page).to have_content('Thanks for joining the TedxUltimo community!')
    end

  end
  
end
