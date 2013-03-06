
class MemberSessionsController < ApplicationController
  respond_to :json

  def create
    @member_session = MemberSession.new(params[:member_session])
    if @member_session.save
      render json: { success: true, id: current_member.id, username: current_member.username}
    else
      render json: { error: "Invalid username or password" }, :status => :unprocessable_entity
    end
  end
  
  def destroy
    @member_session = MemberSession.find
    if @member_session.destroy
      render json: { success: "true" }
    else
      render json: { errors: @member_session.errors }, :status => :unprocessable_entity
    end
  end

  def check
    member_check =  { admin_authenticated: current_member && current_member.username.present? }
    member_check[:id] = current_member.id
    member_check[:username] = current_member.username if current_member
    render json: member_check
  end
end