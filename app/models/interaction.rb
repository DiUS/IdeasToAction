class Interaction < ActiveRecord::Base
  attr_accessible :idea_action, :member, :reaction_text

  belongs_to :idea_action
  belongs_to :member
end
