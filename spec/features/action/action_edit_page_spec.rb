describe "Action edit page", js: true, acceptance: true do
  
  let(:idea_action) { IdeaAction.first }
  let(:content_admin) { Member.find_by_role(Member::ROLE_CONTENT_ADMIN) }

  before do
    Capybara.reset_sessions!
    login(content_admin)
    idea_action.should_not be_nil
    visit "#/ideas/#{idea_action.idea_id}/actions/edit/#{idea_action.id}"
  end

  it "should have the form to edit the action" do
    page.should have_selector '#description'
    page.should have_selector '#featured'
  end

  it 'should have the fields pre-populated with the action details' do
    page.find('#description').value.should eql idea_action.description
    page.find('#featured').checked?.should eql idea_action.featured
  end

  it 'should be able to change the details of the action' do
    time = Time.now
    fill_in 'description', with: "changed on: #{time}"
    page.find('button[ng-click="update()"]').click
    visit "#/ideas/#{idea_action.idea_id}/actions/edit/#{idea_action.id}"
    page.find('#description').value.should eql "changed on: #{time}"
  end
end