class CountsController < ApplicationController

  def index
    render :json => {
      :events => Event.count,
      :talks => Talk.count,
      :ideas => Idea.count,
      :idea_actions => IdeaAction.count
    }
  end
end