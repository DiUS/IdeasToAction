class EventView

  attr_accessor :featured, :recent, :popular

  def initialize
    already_shown = []

    self.featured = Event.featured.viewable.random(1)
    already_shown += self.featured

    self.recent = Event.recent.viewable.excluding_events(already_shown.collect(&:id)).random(2)
    already_shown += self.recent

    self.popular = Event.popular.viewable.excluding_events(already_shown.collect(&:id)).random(2)
  end

end
