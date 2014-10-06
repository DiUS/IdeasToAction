class IdeaView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = Idea.featured.viewable.random(1)
    already_shown += self.featured

    if !already_shown.empty?
      self.recent = Idea.recent.viewable.excluding_ideas(already_shown.collect(&:id)).random(2)
    else      
      self.recent = Idea.recent.viewable.random(2)
    end
    already_shown += self.recent

    if !already_shown.empty?
      self.popular = Idea.popular.viewable.excluding_ideas(already_shown.collect(&:id)).random(2)
    else
      self.popular = Idea.popular.viewable.random(2)
    end
  end

end
