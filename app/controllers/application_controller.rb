class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_session_exists

  private

  def ensure_session_exists
    session = MemberSession.find || MemberSession.create(Member.create!(), true)
  end
end
