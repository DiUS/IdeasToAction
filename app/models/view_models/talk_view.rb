class TalkView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = Talk.featured.viewable.random(1)
    already_shown += self.featured

    self.recent = Talk.recent.viewable.excluding_talks(already_shown.collect(&:id)).random(2)
    already_shown += self.recent

    self.popular = Talk.popular.viewable.excluding_talks(already_shown.collect(&:id)).random(2)
  end

end
