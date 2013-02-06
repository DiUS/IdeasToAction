class Action < ActiveRecord::Base
  attr_accessible :description

  belongs_to :idea

  has_many :actions_taken

  def as_json options = nil
    super.merge(members_actioned_count: members_actioned.size)
  end

  private
  def members_actioned
    Idea.find_by_sql("select distinct at.member_id from " + 
                      "actions a, actions_taken at where " +
                      "at.action_id = a.id and a.id = #{self.id}")
  end
end
