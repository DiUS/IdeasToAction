describe SearchQuery do
  
  let(:search_query) { SearchQuery.new(text: 'query text') }

  it "should validate presence of text" do
    search_query.should be_valid

    search_query.text = nil

    search_query.should_not be_valid
  end
end