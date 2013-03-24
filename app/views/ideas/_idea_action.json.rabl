attributes *IdeaAction.column_names

node(:members_actioned_count) { root_object.members_actioned.size }

member_interaction = root_object.interactions.from_member(@member)

node(:member_interaction) do
  if member_interaction.present?
    {
      :id => member_interaction.id,
      :idea_action_id =>  member_interaction.idea_action_id,
      :member_id =>  member_interaction.member_id,
      :created_at =>  member_interaction.created_at.strftime("%b %d %Y")
    }
  end
end