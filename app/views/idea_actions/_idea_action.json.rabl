attributes :id, :idea_id, :created_at, :updated_at, :featured, :reactions_count

node :description do
  root_object.description.truncate(80)
end
