class IdeaActionView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = IdeaAction.featured.viewable.random(1)
    already_shown += self.featured

    self.recent = IdeaAction.recent.viewable.excluding_idea_actions(already_shown.collect(&:id)).random(4)
    already_shown += self.recent
  end

end
