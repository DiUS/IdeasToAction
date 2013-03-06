module LoginMacros
  def login(member)
    visit "#/login"
    fill_in "username", :with => member.username
    fill_in "password", :with => member.password
    find("#btn-login").click
  end

  def logout
    visit "#/home"
    find(".icon-road").click
  end
end