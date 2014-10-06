class CountsController < ApplicationController

  def index
    render json: {
      ideas: Idea.total,
      idea_actions: IdeaAction.total,
      talks: Talk.total,
      events: Event.total
    }
  end
end