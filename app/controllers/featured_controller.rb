class FeaturedController < ApplicationController
  def index
    render :json => {
      :events => Event.find_all_by_featured(true),
      :talks => Talk.find_all_by_featured(true),
      :ideas => Idea.find_all_by_featured(true),
      :actions => Action.find_all_by_featured(true)
    }
  end
end