require "spec_helper"

describe "login", :js => true do
  let(:content_admin_member) { Member.create(username: "admin", password: "ted", role: Member::ROLE_CONTENT_ADMIN) }

  it "should login the content admin" do
    login(content_admin_member)
    page.should have_content(content_admin_member.username)
  end
end