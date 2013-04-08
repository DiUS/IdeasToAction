object @event_view

child :featured => :featured do
  extends 'events/event'
end

child :recent => :recent do
  extends 'events/event'
end

child :popular => :popular do
  extends 'events/event'
end



