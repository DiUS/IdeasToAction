describe "Found page", js: true do

  describe "Searching" do
    before do
      visit "#/found"
    end 

    context "when typing a search query and submitting" do
      context 'a successful search' do
        before do 
          find("input[type='text']").set("body language")
          find('input.btn').click()
        end

        it "should have results" do
          page.should have_selector(".content-item", text: "Examine your own body language")
          page.should have_selector(".content-item", text: "Body language affects how others see us, but it may also change how we see ourselves.")
        end
      end

      context 'a query with no results' do
        before do 
          find("input[type='text']").set("seriously not going to find this")
          find('input.btn').click()
        end

        it "should have no results" do
          page.should have_selector(".content-item", text: 'No results found for "seriously not going to find this"')
        end
      end

      context 'an empty query' do
        before do 
          find("input[type='text']").set("")
          find('input.btn').click()
        end

        it "should have no results" do
          page.should have_selector(".content-item", text: 'No results found for ""')
        end
      end
    end
  end
end