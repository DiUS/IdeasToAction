class EventView
  attr_accessor :featured, :recent, :popular

  def initialize
    already_selected = []

    random_featured = Event.featured.random(1)
    self.featured = random_featured
    already_selected.concat random_featured

    random_recent = Event.recent.excluding_events(already_selected.collect(&:id)).random(2)
    self.recent = random_recent
    already_selected.concat random_recent

    self.popular =  Event.popular.excluding_events(already_selected.collect(&:id)).random(2)
  end
end