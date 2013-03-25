class Interaction < ActiveRecord::Base
  attr_accessible :idea_action, :idea_action_id, :member, :member_id, :reaction_text

  belongs_to :idea_action
  belongs_to :member

  delegate :description, :to => :idea_action, :prefix => true
  delegate :username, :to => :member, :prefix => true

  def self.find_by_member member
    find(:all, :conditions => ['member_id = ?', member.id])
  end
end
