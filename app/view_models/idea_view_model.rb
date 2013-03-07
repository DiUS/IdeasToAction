require 'bitly'

class IdeaViewModel
  def initialize params
    idea = Idea.find(params[:id])
    @idea_view_model = idea.as_json

    actions = idea.actions
    @idea_view_model['actions'] = []

    actions.each do |action|
      @idea_view_model['actions'] << action.as_json
      member_action_taken = action.actions_taken.from_member(params[:member])
      @idea_view_model['actions'].last['member_action_taken'] = member_action_taken.as_json
      @idea_view_model['actions'].last['member_action_taken']['created_at'] = member_action_taken.created_at.strftime("%b %d %Y") unless member_action_taken.nil?
    end

    @idea_view_model['talks'] = idea.talks.as_json
    @idea_view_model['reactions'] = idea.reactions.as_json
    bitly = Bitly.new(CONFIG[:bitly][:username], CONFIG[:bitly][:api_key])
    @idea_view_model['idea_url'] = bitly.shorten("http://qa.actionman.zerobot.io/ideas/#{idea.id}").short_url
  end

  def as_json
    @idea_view_model
  end
end