class EventsController < ApplicationController
  inherit_resources

  def index
    render json: Event.all
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