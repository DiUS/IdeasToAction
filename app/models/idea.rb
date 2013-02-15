class Idea < ActiveRecord::Base
  attr_accessible :tags, :talks

  belongs_to :member
  validates_presence_of :member

  has_many :talk_to_idea_associations
  has_many :talks, through: :talk_to_idea_associations
  validates_length_of :talks, minimum: 1

  has_many :actions
  has_many :reactions

  has_and_belongs_to_many :tags

  attr_accessible :body, :actions, :reactions

  def as_json options = nil
    super.merge(members_actioned_count: members_actioned.size, tags: tags)
  end

  private
  def members_actioned
    Idea.find_by_sql("select distinct at.member_id from " + 
                      "ideas i, actions_taken at, actions a where " +
                      "a.idea_id = i.id and at.action_id = a.id and i.id = #{self.id}")
  end
end
