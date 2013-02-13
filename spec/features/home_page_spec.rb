describe "Home page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  before do
    visit "/assets/index.html#/home"
  end 

  it "should display welcome text that rattles the bones" do
    page.text.should =~ /(\d+) people; (\d+) ideas; (\d+) actions taken: - transforming ideas worth spreading into actions /
  end
end