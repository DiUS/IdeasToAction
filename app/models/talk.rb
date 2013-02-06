class Talk < ActiveRecord::Base
  attr_accessible :description, :title, :ideas

  has_many :ideas, through: :talk_to_idea_associations

  has_many :talk_to_idea_associations

  belongs_to :event
end
