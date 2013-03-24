 class InteractionsController < ApplicationController
  inherit_resources
  authorize_resource

  respond_to :json

  def create
    interaction = Interaction.create! :idea_action_id => params[:idea_action_id], :member => member
    render :json => interaction
  end
end