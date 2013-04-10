attributes :id, :created_at, :updated_at, :member_id, :featured, :idea_actions_count, :reactions_count

node :description do
  root_object.featured? ? root_object.description : root_object.description.truncate(80)
end
