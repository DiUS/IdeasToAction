class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_member_session

  rescue_from CanCan::AccessDenied do
    render(json: {unauthorized: true}, status: :unauthorized)
  end

  def current_ability
    @current_ability ||= Ability.new(current_member)
  end
  alias_method :ability, :current_ability

  def require_admin_member
    if current_member.nil? || current_member.role == Member::ROLE_REGULAR
      store_location
      flash[:notice] = "You must be logged in to access this page."
      redirect_to new_member_session_url
      false
    end
  end

  helper_method :current_member

  private

  def member_session
		return @member_session if defined?(@member_session)
		@current_user_session = MemberSession.find
  end
  alias_method :current_member_session, :member_session
  alias_method :set_member_session, :member_session

  def member
    @member ||= member_session && member_session.record
  end
  alias_method :current_member, :member

  def store_location
    session[:return_to] = request.url
  end
end
