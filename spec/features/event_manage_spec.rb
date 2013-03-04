describe "Event manage page", js: true, acceptance: true do
  
  let(:event) { Event.find(1) }
  
  before do
    event.should_not be_nil
    visit "#/events/edit/#{event.id}"
  end

  it "should have the form to edit the event" do
    page.should have_selector '#name'
    page.should have_selector '#description'
    page.should have_selector '#logo_image_url'
    page.should have_selector '#hero_image_url'
  end
end