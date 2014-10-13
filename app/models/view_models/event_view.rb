class EventView

  attr_accessor :featured, :recent, :popular, :already_shown

  def initialize
    self.already_shown = []
    set_featured
    set_recent
    set_popular
  end

  def set_featured
    self.featured = Event.featured.viewable.random(1)
    self.already_shown += self.featured
    self.featured
  end

  def set_recent
    recent = Event.recent.viewable
    if !self.already_shown.empty?
      recent = recent.excluding_events(already_shown.collect(&:id))
    end
    self.recent = recent.random(2)
    self.already_shown += self.recent
    self.recent
  end

  def set_popular
    popular = Event.popular.viewable
    if !self.already_shown.empty?
      popular = popular.excluding_events(already_shown.collect(&:id))
    end
    self.popular = popular.random(2)
  end

end
