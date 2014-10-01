attributes *IdeaAction.column_names

node(:completable) { |idea_action| idea_action.completable?(current_member) }
node(:mine) { |idea_action| idea_action.mine?(current_member) }
