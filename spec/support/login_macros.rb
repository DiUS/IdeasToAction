module LoginMacros
  def login(member, password = member.password)
    page.set_rack_session("member_credentials" => member.persistence_token, "member_credentials_id" => member.id)
  end
end