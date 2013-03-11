require_relative '../view_models/idea_view_model'

class IdeasController < ApplicationController
  inherit_resources
  authorize_resource

  belongs_to :talk, optional: true

  respond_to :json

  def random
    render json: Idea.find(:first, :order => 'rand()')
  end

  def react
    idea = Idea.find(params[:id])
    Reaction.create! idea: idea, member: member, :text => params[:text]
    render :nothing => true
  end

  def update
    params['idea'].delete 'talks'
    params['idea'].delete 'actions'
    params['idea'].delete 'reactions'
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
    idea_hash[:actions] = idea_hash[:actions].blank? ? [] : idea_hash[:actions].map { | action_attrs | Action.new(action_attrs) }
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
