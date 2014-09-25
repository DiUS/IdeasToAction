attributes *IdeaAction.column_names

node(:completable) { |idea_action| idea_action.completable?(current_member) }
