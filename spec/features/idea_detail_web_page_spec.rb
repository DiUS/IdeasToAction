describe "Idea detail web page", js: true, acceptance: true do
  
  let(:idea) { Idea.find(17) }

  before :each do
    idea.should_not be_nil
    visit "/ideas/17"
  end

  it "should have a link to open the app" do
    link = page.find_link('Open in application')
    link['href'].should eql 'ideasintoaction://17'
  end

  it "should have a link to download the app" do
    link = page.find('.download')
    link['href'].should eql 'https://play.google.com/store/apps/details?id=com.ted.actionman'
  end

  it 'should display the idea' do
    page.find('iframe')['src'].should eql '/#ideas/17'
  end

end