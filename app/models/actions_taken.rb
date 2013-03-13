class ActionsTaken < ActiveRecord::Base
  self.table_name = 'actions_taken'

  attr_accessible :idea_action, :member

  belongs_to :idea_action
  belongs_to :member
end
