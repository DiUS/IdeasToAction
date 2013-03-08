class TalksController < ApplicationController
  inherit_resources

  belongs_to :event, optional: true

  respond_to :json

  def update
    params['talk'].delete 'ideas'
    update!
  end

  def show
    @talk = Talk.find(params[:id])

    respond_to do |format|
      format.json { render json: @talk, methods: [:ideas] }
    end
  end
end
