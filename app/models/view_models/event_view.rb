class EventView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = Event.featured.viewable.random(1)
    already_shown += self.featured

    if !already_shown.empty?
      self.recent = Event.recent.viewable.excluding_events(already_shown.collect(&:id)).random(2)
    else
      self.recent = Event.recent.viewable.random(2)
    end
    already_shown += self.recent

    if !already_shown.empty?
      self.popular = Event.popular.viewable.excluding_events(already_shown.collect(&:id)).random(2)
    else      
      self.popular = Event.popular.viewable.random(2)
    end
  end

end
