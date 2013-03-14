object @idea

attributes *Idea.column_names

node(:members_actioned_count) { |idea| idea.members_actioned.size  }

node :idea_actions do |idea|
  idea.idea_actions.map do |idea_action|
    idea_action_hash =  {
                          :id => idea_action.id,
                          :description => idea_action.description,
                          :idea_id => idea_action.idea_id,
                          :members_actioned_count =>  idea_action.members_actioned.size
                        }
    member_action_taken_hash = nil
    member_action_taken = idea_action.actions_taken.from_member(@member)
    if member_action_taken.present?
      member_action_taken_hash =  {
                                    :id => member_action_taken.id,
                                    :idea_action_id =>  member_action_taken.idea_action_id,
                                    :member_id =>  member_action_taken.member_id,
                                    :created_at =>  member_action_taken.created_at.strftime("%b %d %Y")
                                  }
    end
    idea_action_hash[:member_action_taken] = member_action_taken_hash
    idea_action_hash
  end
end

child(:talks) { attributes *Talk.column_names }
child(:reactions) { attributes *Reaction.column_names }
child(:tags) { attributes *Tag.column_names }
