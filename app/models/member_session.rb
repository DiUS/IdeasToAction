class MemberSession < Authlogic::Session::Base
  logout_on_timeout false

  remember_me_for 2.years
end