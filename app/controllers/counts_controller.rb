class CountsController < ApplicationController

  def index
    render :json => {
      :members => Member.count,
      :ideas => Idea.count,
      :idea_actions => IdeaAction.count
    }
  end
end