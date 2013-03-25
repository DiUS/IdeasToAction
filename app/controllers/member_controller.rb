class MemberController < ApplicationController
  authorize_resource

  respond_to :json

  def interactions
    render json: Interaction.find_by_member(member), methods: :idea_action
  end
end