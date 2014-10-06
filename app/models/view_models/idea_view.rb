class IdeaView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = Idea.featured.viewable.random(1)
    already_shown += self.featured

    self.recent = Idea.recent.viewable.excluding_ideas(already_shown.collect(&:id)).random(2)
    already_shown += self.recent

    self.popular = Idea.popular.viewable.excluding_ideas(already_shown.collect(&:id)).random(2)
  end

end
