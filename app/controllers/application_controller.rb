class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_session_exists

  def member_session
    @member_session ||= (MemberSession.find || MemberSession.create(Member.create!(), true))
  end

  def member
    @member_session.record
  end

  private

  def ensure_session_exists
    member_session
  end

end
