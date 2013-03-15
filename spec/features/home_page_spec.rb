describe "Home page", js: true, acceptance: true do
  self.use_transactional_fixtures = false

  before do
    visit "#/home"
  end 

  it "should display welcome text that rattles the bones" do
    page.text.should =~ /(\d+) People/
    page.text.should =~ /(\d+) Ideas/
    page.text.should =~ /(\d+) Actions/
    page.text.should =~ /Transforming ideas worth spreading into actions worth taking/
  end

  it "should display a random idea" do
    random_idea = page.find("#random-idea")
    random_idea.should_not be_nil
    random_idea.text.should_not be_empty
  end

  it "should display a random action" do
    random_action = page.find("#random-action")
    random_action.should_not be_nil
    random_action.text.should_not be_empty
  end
end