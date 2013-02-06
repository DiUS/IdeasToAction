class ActionsTaken < ActiveRecord::Base
  self.table_name = 'actions_taken'

  attr_accessible :action, :member

  belongs_to :action
  belongs_to :member
end
