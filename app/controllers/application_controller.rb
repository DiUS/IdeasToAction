class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_session_exists

  def member_session
    @member_session ||= (MemberSession.find || MemberSession.create(Member.create!(), true))
  end

  def member
    @member_session.record
  end

  helper_method :current_member

  private

  def ensure_session_exists
    member_session
  end

  def current_member_session
    return @current_member_session if defined?(@current_member_session)
    @current_member_session = MemberSession.find
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_member_session && current_member_session.record
  end
end
