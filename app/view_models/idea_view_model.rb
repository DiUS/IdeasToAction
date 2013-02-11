class IdeaViewModel

  def initialize params
    idea = Idea.find(params[:id])
    @idea_view_model = idea.as_json

    actions = idea.actions
    @idea_view_model['actions'] = []

    actions.each do |action|
      @idea_view_model['actions'] << action.as_json
      @idea_view_model['actions'].last['member_action_taken'] = action.actions_taken.from_member(params[:member])
    end

    @idea_view_model['reactions'] = idea.reactions.as_json
  end

  def as_json
    @idea_view_model
  end
end