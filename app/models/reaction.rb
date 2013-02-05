class Reaction < ActiveRecord::Base
  attr_accessible :member_id, :idea_id, :text

  belongs_to :idea
end