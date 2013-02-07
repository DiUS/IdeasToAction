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
end