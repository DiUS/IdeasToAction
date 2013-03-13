object @idea

attributes *Idea.column_names

node(:members_actioned_count) { |idea| idea.members_actioned.size  }

child :idea_actions do |action|
  attributes *IdeaAction.column_names
  member_action_taken = action.first.actions_taken.from_member(@member)
  node(:member_action_taken) do
    unless member_action_taken.nil?
      { :id => member_action_taken.id,
        :idea_action_id =>  member_action_taken.idea_action_id,
        :member_id =>  member_action_taken.member_id,
        :created_at =>  member_action_taken.created_at.strftime("%b %d %Y")
      }
    end
  end
  node(:members_actioned_count) { action.first.members_actioned.size }
end

child(:talks) { attributes *Talk.column_names }
child(:reactions) { attributes *Reaction.column_names }
child(:tags) { attributes *Tag.column_names }
