describe "Action edit page", js: true, acceptance: true do
  
  let(:action) { IdeaAction.first }
  let(:content_admin) { Member.find_by_role(Member::ROLE_CONTENT_ADMIN) }

  before do
    Capybara.reset_sessions!
    login(content_admin)
    action.should_not be_nil
    visit "#/actions/edit/#{action.id}"
  end

  it "should have the form to edit the action" do
    page.should have_selector '#description'
  end

  it 'should have the fields pre-populated with the action details' do
    page.find('#description').value.should eql action.description
  end

  it 'should be able to change the details of the action' do
    time = Time.now
    fill_in 'description', with: "changed on: #{time}"
    page.find('button[ng-click="update()"]').click
    visit "#/actions/edit/#{action.id}"
    page.find('#description').value.should eql "changed on: #{time}"
  end
end