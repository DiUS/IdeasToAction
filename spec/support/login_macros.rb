module LoginMacros
  def login(member)
    visit "#/login"
    fill_in "username", :with => member.username
    fill_in "password", :with => member.password
    find("#login-btn").click
  end
end