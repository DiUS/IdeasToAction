class CountsController < ApplicationController

  def index
    render :json => {
      :members => Member.count,
      :ideas => Idea.count,
      :actions => Action.count
    }
  end
end