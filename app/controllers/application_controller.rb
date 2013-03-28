class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_session_exists

  rescue_from CanCan::AccessDenied do
    render json: {:unauthorized => true}, :status => :unauthorized
  end

  def member_session
    @member_session ||= (MemberSession.find || MemberSession.create(Member.create!(), true))
  end

  def member
    @member_session.record
  end

  def current_ability
    @current_ability ||= Ability.new(current_member)
  end

  def require_admin_member
    if current_member.nil? || current_member.role == Member::ROLE_REGULAR
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_member_session_url
      false
    end
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

  def store_location
    session[:return_to] = request.url
  end
end
