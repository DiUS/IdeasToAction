class MemberController < ApplicationController
  respond_to :json

  def show
    render json: member
  end

  def actions
    render json: member.actions
  end

  def reactions
    render json: member.reactions
  end
end