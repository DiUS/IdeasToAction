attributes :id, :created_at, :updated_at, :member_id, :featured, :idea_actions_count, :reactions_count

node :description do
  root_object.description.truncate(80)
end
