describe 'Login page', js: true, acceptance: true do
  before do
    visit '/#/login'
  end

  describe 'page content' do
    it 'should have a welcome message' do
      expect(page).to have_content('Hello and welcome to TEDxUltimo')
    end

    it 'should have an email field' do
      expect(page).to have_field('email')
    end
  end
  
  describe 'logging in' do
    let(:email) { 'user@example.com' }

    before do
      fill_in 'email', with: email
      find('#login-submit').click
    end

    it 'should naviagate to home page' do
      expect(page).to have_content('The Ultimate Place to Start Something')
    end
  end
end
