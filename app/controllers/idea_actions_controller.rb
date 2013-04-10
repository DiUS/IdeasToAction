class IdeaActionsController < ApplicationController
  inherit_resources
  authorize_resource

  belongs_to :idea, :optional => true

  respond_to :json

  def index
    if params[:mix] && params[:mix] == "true"
      @idea_action_view = IdeaActionView.new
      render 'idea_actions'
    else
      index!
    end
  end

  def random
    render json: IdeaAction.featured.random.first
  end

  def recent
    @idea_actions = IdeaAction.order("created_at desc").limit(10)

    respond_to do |format|
      format.json { render json: @idea_actions }
    end
  end
end