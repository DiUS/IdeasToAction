describe "Found page", js: true, acceptance: true do

  describe "Searching" do
    before do
      visit "#/found"
    end 

    context "when typing a search query and submitting" do
      context 'a successful search' do
        before do 
          find("#search input").set("body language")
          find('button').click()
        end

        it "should have results" do
          sleep 1
          page.should have_selector(".result", text: "Examine your own body language")
          page.should have_selector(".result", text: "Body language affects how others see us, but it may also change how we see ourselves.")
        end
      end

      context 'a query with no results' do
        before do 
          find("#search input").set("seriously not going to find this")
          find('button').click()
        end

        it "should have no results" do
          sleep 1
          page.should have_selector(".description", text: "No results found!")
        end
      end

      context 'an empty query' do
        before do 
          find("#search input").set("")
          find('button').click()
        end

        it "should have no results" do
          sleep 1
          page.should have_selector(".description", text: "No results found!")
        end
      end
    end
  end
end