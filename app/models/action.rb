class Action < ActiveRecord::Base
  attr_accessible :description

  belongs_to :idea

  has_many :actions_taken
end
