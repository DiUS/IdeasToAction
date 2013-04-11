class TalksController < ApplicationController
  inherit_resources

  belongs_to :event, optional: true

  respond_to :json

  def index
    if params[:mix] && params[:mix] == "true"
      @talk_view = TalkView.new
      render 'talks'
    else
      render :nothing => true
    end
  end

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
