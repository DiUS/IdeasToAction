class TalkToIdeaAssociation < ActiveRecord::Base
  attr_accessible :idea_id, :talk_id
  attr_accessible :idea, :talk

  belongs_to :idea
  belongs_to :talk
end
