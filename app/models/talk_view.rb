class TalkView
  attr_accessor :featured, :recent, :popular

  def initialize
    already_selected = []

    random_featured = Talk.featured.random(1)
    self.featured = random_featured
    already_selected.concat random_featured

    random_recent = Talk.recent.excluding_talks(already_selected).random(2)
    self.recent = random_recent
    already_selected.concat random_recent

    self.popular =  Talk.popular.excluding_talks(already_selected).random(2)
  end
end