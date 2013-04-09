object @idea_view

child :featured => :featured do
  extends 'ideas/idea'
end

child :recent => :recent do
  extends 'ideas/idea'
end

child :popular => :popular do
  extends 'ideas/idea'
end
