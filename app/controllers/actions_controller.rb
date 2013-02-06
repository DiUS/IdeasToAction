class ActionsController < ApplicationController
  def recent
    @actions = Action.order("created_at desc").limit(10)

    respond_to do |format|
      format.json { render json: @actions }
    end
  end
end