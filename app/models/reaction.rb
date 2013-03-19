class Reaction < ActiveRecord::Base
  attr_accessible :member, :text, :idea_action

  belongs_to :idea_action
  belongs_to :member
end