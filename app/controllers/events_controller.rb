class EventsController < ApplicationController
  inherit_resources
  authorize_resource

  respond_to :json

  def index
    if params[:mix] && params[:mix] == "true"
      @event_view = EventView.new
      render 'index'
    else
      render json: Event.all
    end
  end

  def update
    params['event'].delete 'talks'
    update!
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.json { render json: @event, methods: [:talks] }
    end
  end

  def ideas
    ideas = Event.find(params[:id]).ideas

    respond_to do |format|
      format.json { render json: ideas }
    end   
  end
end