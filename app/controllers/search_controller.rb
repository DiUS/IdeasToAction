class SearchController < ApplicationController

  respond_to :json

  def index
    params.delete(:controller)
    params.delete(:action)
    params.delete(:format)

    search_query = SearchQuery.new(params)

    unless search_query.valid?
      render json: { errors: search_query.errors }, :status => :unprocessable_entity
    else
      search = create_search(search_query)

      respond_to do |format|
        format.json { render json: search.results }
      end
    end
  end

  private

  def create_search(search_query)
    Tire.search("#{Rails.env}-all") do
      query do
        string search_query.text
      end
    end    
  end

end
