class TalkView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = Talk.featured.viewable.random(1)
    already_shown += self.featured

    if !already_shown.empty?
      self.recent = Talk.recent.viewable.excluding_talks(already_shown.collect(&:id)).random(2)
    else
      self.recent = Talk.recent.viewable.random(2)
    end
    already_shown += self.recent

    if !already_shown.empty?
      self.popular = Talk.popular.viewable.excluding_talks(already_shown.collect(&:id)).random(2)
    else
      self.popular = Talk.popular.viewable.random(2)      
    end
  end

end
