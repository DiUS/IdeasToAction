attributes *IdeaAction.column_names

node(:members_actioned_count) { root_object.members_actioned.size }

member_action_taken = root_object.actions_taken.from_member(@member)

node(:member_action_taken) do
  if member_action_taken.present?
    {
      :id => member_action_taken.id,
      :idea_action_id =>  member_action_taken.idea_action_id,
      :member_id =>  member_action_taken.member_id,
      :created_at =>  member_action_taken.created_at.strftime("%b %d %Y")
    }
  end
end