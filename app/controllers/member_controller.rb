class MemberController < ApplicationController
  authorize_resource

  respond_to :json

  def show
    render json: member
  end

  def actions
    render json: member.idea_actions
  end
end