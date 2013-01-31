describe "End to End Sanity Check", js: true, acceptance: true do
  
  before :each do
    visit '/assets/index.html'
  end

  it "should have a title" do
    page.should have_selector("title", text: 'Actionman')
  end
end