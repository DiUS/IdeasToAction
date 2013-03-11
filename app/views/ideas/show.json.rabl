object @idea

attributes *Idea.column_names

node(:members_actioned_count) { |idea| idea.members_actioned.size  }

child :actions do |action|
  attributes :created_at, :description, :id
  member_action_taken = action.first.actions_taken.from_member(@member)
  node(:member_action_taken) do
    attributes :created_at, :description, :id, :member_id, :updated_at
    node(:created_at) { member_action_taken.created_at.strftime("%b %d %Y") } unless member_action_taken.nil?
  end
  node(:members_actioned_count) { action.first.members_actioned.size }
end

child(:talks) { attributes :title }
child(:reactions) { attributes *Reaction.column_names }
child(:tags) { attributes *Tag.column_names }
