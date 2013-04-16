describe "Home page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  before do
    visit "#/home"
  end 

  it "should display welcome text that rattles the bones" do
    page.text.should =~ /(\d+) Ideas/
    page.text.should =~ /(\d+) Actions/
    page.text.should =~ /(\d+) Talks/
    page.text.should =~ /(\d+) Events/
    page.text.should =~ /Transforming ideas worth spreading into actions worth taking/
  end

  it 'should link to ideas' do
    page.should have_selector('[ng-href="/ideas"]')
  end

  it 'should link to actions' do
    page.should have_selector('[ng-href="/actions"]')
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
end