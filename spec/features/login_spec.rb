require "spec_helper"

describe "login", :js => true do
  let(:content_admin_member) { Member.create(username: "admin", password: "ted", role: Member::ROLE_CONTENT_ADMIN) }

  it "should login the content admin" do
    login(content_admin_member)
    page.should have_content(content_admin_member.username)
  end

  it 'should allow the logged in user to edit all events' do
    page.should_not have_selector '[ng-href="/events/edit"]'
    login(content_admin_member)
    visit "#/home"
    page.should have_selector '[ng-href="/events/edit"]'
  end

  it "should logout the content admin" do
    login(content_admin_member)
    logout
    visit "#/home" # need a refresh for headless JS driver
    page.should_not have_content(content_admin_member.username)
  end
end