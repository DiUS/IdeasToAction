class IdeaActionsController < ApplicationController
  inherit_resources
  authorize_resource

  belongs_to :idea, :optional => true

  respond_to :json

  def random
    render json: IdeaAction.featured_only.random
  end

  def react
    idea_action = IdeaAction.find(params[:id])
    Reaction.create! idea_action: idea_action, member: member, :text => params[:text]
    render :nothing => true
  end

  def doneIt
    idea_action = IdeaAction.find(params[:id])
    ActionsTaken.create! :member => member, :idea_action => idea_action
    render :nothing => true
  end

  def recent
    @idea_actions = IdeaAction.order("created_at desc").limit(10)

    respond_to do |format|
      format.json { render json: @idea_actions }
    end
  end
end