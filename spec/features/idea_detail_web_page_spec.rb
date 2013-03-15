describe "Idea detail web page", js: true, acceptance: true do
  
  let(:idea) { Idea.find(17) }

  before :each do
    VCR.use_cassette('bitly_url') do
      idea.should_not be_nil
      visit "/ideas/17"
    end
  end

  it "should have a link to open the app" do
    link = page.find_link('Open in app')
    link['href'].should eql 'ideasintoaction://17'
  end

  xit "should have a link to download the app" do
    link = page.find('.download')
    link['href'].should eql 'https://play.google.com/store/apps/details?id=com.ted.ideasintoaction'
  end

  it 'should display the idea' do
    page.should have_content idea.description
  end

end