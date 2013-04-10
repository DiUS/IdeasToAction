class IdeaActionView
  attr_accessor :featured, :recent, :popular

  def initialize
    already_selected = []

    random_featured = IdeaAction.featured.random(1)
    self.featured = random_featured
    already_selected.concat random_featured

    random_recent = IdeaAction.recent.excluding_idea_actions(already_selected).random(2)
    self.recent = random_recent
    already_selected.concat random_recent

    self.popular =  IdeaAction.popular.excluding_idea_actions(already_selected).random(2)
  end
end