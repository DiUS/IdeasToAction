class CountsController < ApplicationController

  def index
    render :json => {
      :members => Member.count,
      :ideas => Idea.count,
      :actions_taken => ActionsTaken.count
    }
  end
end