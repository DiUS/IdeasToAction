describe "Search page", js: true, acceptance: true do
  before do
    visit "#/search"
  end 

  it "should have a search text field" do
    page.should have_selector("#search-text", visible: true)
  end

  context "when typing a search query" do

    before :each do 
      fill_in "search-text", with: "body language"
    end

    it "should have results" do
      sleep 1
      page.should have_selector(".result", text: "Examine your own body language")
      page.should have_selector(".result", text: "Body language affects how others see us, but it may also change how we see ourselves.")
    end
  end
end