object @talk_view

child :featured => :featured do
  extends 'talks/talk'
end

child :recent => :recent do
  extends 'talks/talk'
end

child :popular => :popular do
  extends 'talks/talk'
end
