shared_examples_for "a collapsible" do
  def collapsible
    page.find(".collapsible[title='#{title}']")
  end

  def items 
    collapsible.find(".items")
  end

  def header 
    collapsible.find(".header")
  end

  def items_should_be_visible(visible = true)
    collapsible.should have_selector('.items', visible: visible)
  end

  def items_should_not_be_visible
    items_should_be_visible(false)
  end

  it "should toggle the items when the header is clicked" do
    VCR.use_cassette('bitly_url') do
      if (respond_to?(:starts_as_collapsed?) ? starts_as_collapsed? : true)
        items.should_not be_visible
        header.click
      end
      items_should_be_visible
      header.click
      items_should_not_be_visible
    end
  end

  it "should have the items content" do
    VCR.use_cassette('bitly_url') do
      item_contents.each do | item_content |
        items.should have_content item_content
      end
    end
  end
end 

