class ActionsController < ApplicationController
  inherit_resources

  belongs_to :idea, :optional => true

  respond_to :json

  def recent
    @actions = Action.order("created_at desc").limit(10)

    respond_to do |format|
      format.json { render json: @actions }
    end
  end

  def doneIt
    action = Action.find(params[:id])
    ActionsTaken.create! :member => member, :action => action
    render :nothing => true
  end
end