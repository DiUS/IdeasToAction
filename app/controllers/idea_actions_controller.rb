class IdeaActionsController < ApplicationController
  inherit_resources
  authorize_resource

  belongs_to :idea, :optional => true

  respond_to :json

  def random
    render json: IdeaAction.find(:first, :order => 'rand()')
  end

  def recent
    @idea_actions = IdeaAction.order("created_at desc").limit(10)

    respond_to do |format|
      format.json { render json: @idea_actions }
    end
  end

  def doneIt
    idea_action = IdeaAction.find(params[:id])
    ActionsTaken.create! :member => member, :idea_action => idea_action
    render :nothing => true
  end
end