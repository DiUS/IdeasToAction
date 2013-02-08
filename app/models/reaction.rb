class Reaction < ActiveRecord::Base
  attr_accessible :member, :idea, :text

  belongs_to :idea
  belongs_to :member
end