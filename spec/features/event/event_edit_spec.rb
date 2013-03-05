describe "Event edit page", js: true, acceptance: true do
  
  let(:event) { Event.find_by_name('TEDActive') }
  
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

  it 'should have the fields pre-populated with the event details' do
    page.find('#name').value.should eql event.name
    page.find('#description').value.should eql event.description
    page.find('#logo_image_url').value.should eql event.logo_image_url
    page.find('#hero_image_url').value.should eql event.hero_image_url
  end

  xit 'should be able to change the details of the event' do
    time = Time.now
    fill_in 'description', with: "changed on: #{time}"
    page.find('button[ng-click="update()"]').click
    visit "#/events/edit/#{event.id}"
    page.find('#description').value.should eql "changed on: #{time}"
  end
end