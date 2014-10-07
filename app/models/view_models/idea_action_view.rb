class IdeaActionView

  attr_accessor :featured, :recent, :already_shown

  def initialize
    self.already_shown = []
    set_featured
    set_recent
  end

  def set_featured
    self.featured = IdeaAction.featured.viewable.random(1)
    self.already_shown += self.featured
  end

  def set_recent
    recent = IdeaAction.recent.viewable
    if !self.already_shown.empty?
      recent = recent.excluding_idea_actions(already_shown.collect(&:id))
    end
    self.recent = recent.random(4)
  end

end
