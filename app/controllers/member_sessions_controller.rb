class MemberSessionsController < ApplicationController
  layout "web_login"

	before_filter :create_member_if_new, :only => :create

  def new
    @member_session = MemberSession.new
  end

  def create
    @member_session = MemberSession.new(params[:member_session])

    respond_to do |format|
      if @member_session.save
        format.html { redirect_to admin_root_path }
        format.json { render json: { success: true, id: current_member.id, email: current_member.email} }
      else
        format.html { render 'new' }
        format.json { render json: { error: 'Email address is invalid' }, :status => :unprocessable_entity }
      end
    end
  end
  
  def logout
    @member_session = MemberSession.find

    respond_to do |format|
      if @member_session.destroy
        format.html { redirect_to new_member_session_path, :notice => "You have logged out successfully." }
        format.json { render json: { success: "true" } }
      else
        format.json { render json: { errors: @member_session.errors }, :status => :unprocessable_entity }
        format.html do
          redirect_to admin_root_path, :error => "Logout failed, please try again."
        end
      end
    end
  end

  def check
    member_check =  { admin_authenticated: current_member && current_member.email.present? }
    member_check[:id] = current_member.id if current_member
    member_check[:email] = current_member.email if current_member
    render json: member_check
	end

	private

	def create_member_if_new
		if Member.where(email: params[:member_session][:email]).empty?
			Member.create email: params[:member_session][:email], password: params[:member_session][:password]
		end
	end
end
