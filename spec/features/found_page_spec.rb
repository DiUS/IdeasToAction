describe "Found page", js: true, acceptance: true do

  describe "Searching" do
    before do
      visit "/#/found"
    end 

    context "when typing a search query and submitting" do
      context 'a successful search' do
        before do 
          find("#found input[type='text']").set("body language")
          find('#found input.btn').click()
        end

        it "should have results" do
          page.should have_selector("#found .content-item", text: "Examine your own body language")
          page.should have_selector("#found .content-item", text: "Body language affects how others see us, but it may also change how we see ourselves.")
        end
      end

      context 'a query with no results' do
        before do 
          find("#found input[type='text']").set("seriously not going to find this")
          find('#found input.btn').click()
        end

        it "should have no results" do
          page.should have_selector("#found .content-item", text: 'No results found for "seriously not going to find this"')
        end
      end

      context 'an empty query' do
        before do 
          find("#found input[type='text']").set("")
          find('#found input.btn').click()
        end

        it "should have no results" do
          page.should have_selector("#found .content-item", text: 'No results found for ""')
        end
      end
    end
  end
end