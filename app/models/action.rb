class Action < ActiveRecord::Base
  attr_accessible :description

  belongs_to :idea
end
