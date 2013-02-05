class Idea < ActiveRecord::Base
  has_many :actions
  has_many :reactions

  attr_accessible :body, :actions, :reactions

  def as_json options = nil
    super.merge(members_actioned_count: members_actioned.size)
  end

  private
  def members_actioned
    Idea.find_by_sql("select distinct at.member_id from " + 
                      "ideas i, actions_taken at, actions a where " +
                      "a.idea_id = i.id and at.action_id = a.id and i.id = #{self.id}")
  end
end
