class IdeasController < ApplicationController
  inherit_resources
  authorize_resource

  belongs_to :talk, optional: true

  respond_to :json

  def index
    if params[:mix] && params[:mix] == "true"
      @idea_view = IdeaView.new
      render 'ideas'
    elsif !params[:excluding].blank?
      idea_ids = params[:excluding].split(',')
      render json: Idea.excluding_ideas(idea_ids).random(5)
    else
      render :nothing => true
    end
  end

  def random
    render json: Idea.featured.random.first
  end

  def update
    params['idea'].delete 'talks'
    params['idea'].delete 'idea_actions'
    params['idea'].delete 'interactions'
    params['idea'].delete 'tags'
    update!
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find(params[:id])
    @member = member

    respond_to do |format|
      format.html { render :open_in_app }
      format.json { render 'show' }
    end
  end

  def show_idea_url
    idea = Idea.find(params[:id])
    render json: { idea_url: idea.bitly_url }
  end

  # POST /ideas
  # POST /ideas.json
  def create
    idea_hash = params[:idea]
    idea_hash[:idea_actions] = idea_hash[:idea_actions].blank? ? [] : idea_hash[:idea_actions].map { | action_attrs | IdeaAction.new(action_attrs.merge(member: current_member)) }
    idea_hash[:talks] = idea_hash[:talks].blank? ? [] : idea_hash[:talks].map { | talk_attrs | Talk.find(talk_attrs[:id]) }

    @idea = Idea.new(idea_hash)
    @idea.member = member

    respond_to do |format|
      if @idea.save
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

end
